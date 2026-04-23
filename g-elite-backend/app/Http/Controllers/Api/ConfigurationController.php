<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ConfigurationPart;
use App\Models\Product;
use App\Models\WatchConfiguration;
use App\Services\AuditLogService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class ConfigurationController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'parts' => 'required|array|size:4',
            'parts.*' => 'required|integer|distinct'
        ]);

        $user = $request->user();

        $products = Product::whereIn('id', $request->parts)
            ->where('is_active', 1)
            ->get();

        if ($products->count() !== 4) {
            throw ValidationException::withMessages([
                'parts' => ['A konfigurációhoz 4 különböző, aktív alkatrész szükséges.']
            ]);
        }

        $types = $products->pluck('type')->sort()->values()->all();
        $expectedTypes = collect(['case', 'strap', 'dial', 'hands'])->sort()->values()->all();

        if ($types !== $expectedTypes) {
            throw ValidationException::withMessages([
                'parts' => ['Pontosan 1 tok, 1 szíj, 1 számlap és 1 mutató szükséges.']
            ]);
        }

        $configuration = DB::transaction(function () use ($request, $user, $products) {
            $totalPrice = $products->sum('price');

            $configuration = WatchConfiguration::create([
                'user_id' => $user->id,
                'name' => $request->name,
                'total_price' => $totalPrice
            ]);

            foreach ($products as $product) {
                ConfigurationPart::create([
                    'configuration_id' => $configuration->id,
                    'product_id' => $product->id
                ]);
            }

            return $configuration;
        });

        $configuration->load('parts.product', 'user');

        AuditLogService::log(
            $user,
            'create',
            'watch_configuration',
            $configuration->id,
            null,
            $configuration->toArray()
        );

        return response()->json([
            'message' => 'Konfiguráció sikeresen mentve.',
            'configuration' => $configuration
        ], 201);
    }

    public function show($id)
    {
        $configuration = WatchConfiguration::with([
            'user',
            'parts.product'
        ])->findOrFail($id);

        return response()->json($configuration);
    }

    public function myConfigurations(Request $request)
    {
        $configurations = WatchConfiguration::with('parts.product')
            ->where('user_id', $request->user()->id)
            ->orderByDesc('id')
            ->get();

        return response()->json($configurations);
    }
}