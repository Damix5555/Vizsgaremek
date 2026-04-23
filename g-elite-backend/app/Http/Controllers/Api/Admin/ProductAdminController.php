<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Services\AuditLogService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProductAdminController extends Controller
{
    public function index()
    {
        return response()->json(
            Product::orderByDesc('id')->get()
        );
    }

    public function show($id)
    {
        return response()->json(
            Product::findOrFail($id)
        );
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'type' => 'required|in:case,strap,dial,hands',
            'color' => 'required|string|max:50',
            'material' => 'required|string|max:50',
            'price' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
            'is_active' => 'required|boolean',
            'image' => 'nullable|image|max:2048',
        ]);

        $imageUrl = null;

        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('products', 'public');
            $imageUrl = 'storage/' . $path;
        }

        $product = Product::create([
            'name' => $request->name,
            'type' => $request->type,
            'color' => $request->color,
            'material' => $request->material,
            'price' => $request->price,
            'image_url' => $imageUrl,
            'stock' => $request->stock,
            'is_active' => $request->boolean('is_active'),
        ]);

        AuditLogService::log(
            $request->user(),
            'create',
            'product',
            $product->id,
            null,
            $product->toArray()
        );

        return response()->json([
            'message' => 'Termék sikeresen létrehozva.',
            'product' => $product
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $product = Product::findOrFail($id);
        $old = $product->toArray();

        $request->validate([
            'name' => 'required|string|max:100',
            'type' => 'required|in:case,strap,dial,hands',
            'color' => 'required|string|max:50',
            'material' => 'required|string|max:50',
            'price' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
            'is_active' => 'required|boolean',
            'image' => 'nullable|image|max:2048',
        ]);

        $imageUrl = $product->image_url;

        if ($request->hasFile('image')) {
            if ($product->image_url && str_starts_with($product->image_url, 'storage/')) {
                $oldPath = str_replace('storage/', '', $product->image_url);
                Storage::disk('public')->delete($oldPath);
            }

            $path = $request->file('image')->store('products', 'public');
            $imageUrl = 'storage/' . $path;
        }

        $product->update([
            'name' => $request->name,
            'type' => $request->type,
            'color' => $request->color,
            'material' => $request->material,
            'price' => $request->price,
            'image_url' => $imageUrl,
            'stock' => $request->stock,
            'is_active' => $request->boolean('is_active'),
        ]);

        AuditLogService::log(
            $request->user(),
            'update',
            'product',
            $product->id,
            $old,
            $product->fresh()->toArray()
        );

        return response()->json([
            'message' => 'Termék sikeresen módosítva.',
            'product' => $product->fresh()
        ]);
    }

    public function destroy(Request $request, $id)
    {
        $product = Product::findOrFail($id);

        if ($product->configurationParts()->exists()) {
            return response()->json([
                'message' => 'A termék már használatban van konfigurációban, ezért nem törölhető fizikailag.'
            ], 409);
        }

        $old = $product->toArray();

        if ($product->image_url && str_starts_with($product->image_url, 'storage/')) {
            $oldPath = str_replace('storage/', '', $product->image_url);
            Storage::disk('public')->delete($oldPath);
        }

        $product->delete();

        AuditLogService::log(
            $request->user(),
            'delete',
            'product',
            $id,
            $old,
            null
        );

        return response()->json([
            'message' => 'Termék sikeresen törölve.'
        ]);
    }
}