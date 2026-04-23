<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\PrebuiltWatch;
use App\Models\WatchConfiguration;
use App\Services\AuditLogService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class OrderController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'address' => 'required|string|max:255',
            'phone' => 'required|string|max:50',
            'items' => 'required|array|min:1',
            'items.*.quantity' => 'nullable|integer|min:1',
            'items.*.configuration_id' => 'nullable|integer',
            'items.*.prebuilt_watch_id' => 'nullable|integer',
        ]);

        $user = $request->user();

        $order = DB::transaction(function () use ($request, $user) {
            $order = Order::create([
                'user_id' => $user->id,
                'status' => 'pending',
                'total_price' => 0,
                'address' => $request->address,
                'phone' => $request->phone
            ]);

            $totalPrice = 0;

            foreach ($request->items as $index => $item) {
                $hasConfiguration = !empty($item['configuration_id']);
                $hasPrebuilt = !empty($item['prebuilt_watch_id']);

                if (($hasConfiguration && $hasPrebuilt) || (!$hasConfiguration && !$hasPrebuilt)) {
                    throw ValidationException::withMessages([
                        "items.$index" => ['Egy rendelési tételben vagy configuration_id, vagy prebuilt_watch_id adható meg.']
                    ]);
                }

                $quantity = $item['quantity'] ?? 1;
                $unitPrice = 0;

                if ($hasConfiguration) {
                    $configuration = WatchConfiguration::with('parts.product')
                        ->where('user_id', $user->id)
                        ->findOrFail($item['configuration_id']);

                    foreach ($configuration->parts as $part) {
                        if (!$part->product || (int) $part->product->stock < $quantity) {
                            throw ValidationException::withMessages([
                                "items.$index.configuration_id" => ['Nincs elegendő készlet a konfiguráció egyik alkatrészéből.']
                            ]);
                        }
                    }

                    foreach ($configuration->parts as $part) {
                        $part->product->decrement('stock', $quantity);
                    }

                    $unitPrice = $configuration->total_price;

                    OrderItem::create([
                        'order_id' => $order->id,
                        'configuration_id' => $configuration->id,
                        'prebuilt_watch_id' => null,
                        'quantity' => $quantity,
                        'price' => $unitPrice
                    ]);
                }

                if ($hasPrebuilt) {
                    $watch = PrebuiltWatch::where('is_active', 1)
                        ->findOrFail($item['prebuilt_watch_id']);

                    if ((int) $watch->stock < $quantity) {
                        throw ValidationException::withMessages([
                            "items.$index.prebuilt_watch_id" => ['Nincs elegendő készlet az előre összeállított órából.']
                        ]);
                    }

                    $watch->decrement('stock', $quantity);

                    $unitPrice = $watch->price;

                    OrderItem::create([
                        'order_id' => $order->id,
                        'configuration_id' => null,
                        'prebuilt_watch_id' => $watch->id,
                        'quantity' => $quantity,
                        'price' => $unitPrice
                    ]);
                }

                $totalPrice += ($unitPrice * $quantity);
            }

            $order->update([
                'total_price' => $totalPrice
            ]);

            return $order;
        });

        $order->load([
            'user',
            'items.configuration.parts.product',
            'items.prebuiltWatch'
        ]);

        AuditLogService::log(
            $user,
            'create',
            'order',
            $order->id,
            null,
            $order->toArray()
        );

        return response()->json([
            'message' => 'Rendelés sikeresen létrehozva.',
            'order' => $order
        ], 201);
    }

    public function show(Request $request, $id)
    {
        $order = Order::with([
            'user',
            'items.configuration.parts.product',
            'items.prebuiltWatch'
        ])
            ->where('user_id', $request->user()->id)
            ->findOrFail($id);

        return response()->json($order);
    }

    public function myOrders(Request $request)
    {
        $orders = Order::with([
            'items.configuration.parts.product',
            'items.prebuiltWatch'
        ])
            ->where('user_id', $request->user()->id)
            ->orderByDesc('id')
            ->get();

        return response()->json($orders);
    }

    public function updateStatus(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:pending,completed,cancelled'
        ]);

        $order = Order::findOrFail($id);
        $old = $order->toArray();

        $order->update([
            'status' => $request->status
        ]);

        AuditLogService::log(
            $request->user(),
            'update_status',
            'order',
            $order->id,
            $old,
            $order->fresh()->toArray()
        );

        return response()->json([
            'message' => 'Rendelés státusza frissítve.',
            'order' => $order->fresh()
        ]);
    }
}