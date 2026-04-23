<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Services\AuditLogService;
use Illuminate\Http\Request;

class OrderAdminController extends Controller
{
    public function index()
    {
        return response()->json(
            Order::with('user')
                ->orderByDesc('id')
                ->get()
        );
    }

    public function show($id)
    {
        return response()->json(
            Order::with(['user', 'items'])->findOrFail($id)
        );
    }

    public function updateStatus(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:pending,paid,shipped,completed,cancelled',
        ]);

        $order = Order::findOrFail($id);

        $old = $order->toArray();

        $order->update([
            'status' => $request->status,
        ]);

        AuditLogService::log(
            $request->user(),
            'update',
            'order',
            $order->id,
            $old,
            $order->fresh()->toArray()
        );

        return response()->json([
            'message' => 'Rendelés státusz frissítve.',
            'order' => $order
        ]);
    }
}