<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $query = Product::query()->where('is_active', 1);

        if ($request->filled('type')) {
            $query->where('type', $request->type);
        }

        if ($request->filled('color')) {
            $query->where('color', $request->color);
        }

        if ($request->filled('material')) {
            $query->where('material', $request->material);
        }

        if ($request->filled('search')) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }

        $products = $query
            ->orderBy('type')
            ->orderBy('name')
            ->get();

        return response()->json($products);
    }

    public function byType($type)
    {
        $allowedTypes = ['case', 'strap', 'dial', 'hands'];

        if (!in_array($type, $allowedTypes)) {
            throw ValidationException::withMessages([
                'type' => ['Érvénytelen terméktípus.']
            ]);
        }

        $products = Product::where('type', $type)
            ->where('is_active', 1)
            ->orderBy('name')
            ->get();

        return response()->json($products);
    }

    public function show($id)
    {
        $product = Product::where('is_active', 1)->findOrFail($id);

        return response()->json($product);
    }
}