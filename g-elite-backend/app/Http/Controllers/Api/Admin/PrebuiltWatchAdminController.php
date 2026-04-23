<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\PrebuiltWatch;
use App\Services\AuditLogService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PrebuiltWatchAdminController extends Controller
{
    public function index()
    {
        return response()->json(
            PrebuiltWatch::orderByDesc('id')->get()
        );
    }

    public function show($id)
    {
        return response()->json(
            PrebuiltWatch::findOrFail($id)
        );
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'description' => 'nullable|string',
            'price' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
            'is_active' => 'required|boolean',
            'image' => 'nullable|image|max:2048',
        ]);

        $imageUrl = null;

        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('prebuilt-watches', 'public');
            $imageUrl = 'storage/' . $path;
        }

        $watch = PrebuiltWatch::create([
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
            'image_url' => $imageUrl,
            'stock' => $request->stock,
            'is_active' => $request->boolean('is_active'),
        ]);

        AuditLogService::log(
            $request->user(),
            'create',
            'prebuilt_watch',
            $watch->id,
            null,
            $watch->toArray()
        );

        return response()->json([
            'message' => 'Előre összeállított óra sikeresen létrehozva.',
            'watch' => $watch
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $watch = PrebuiltWatch::findOrFail($id);
        $old = $watch->toArray();

        $request->validate([
            'name' => 'required|string|max:100',
            'description' => 'nullable|string',
            'price' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
            'is_active' => 'required|boolean',
            'image' => 'nullable|image|max:2048',
        ]);

        $imageUrl = $watch->image_url;

        if ($request->hasFile('image')) {
            if ($watch->image_url && str_starts_with($watch->image_url, 'storage/')) {
                $oldPath = str_replace('storage/', '', $watch->image_url);
                Storage::disk('public')->delete($oldPath);
            }

            $path = $request->file('image')->store('prebuilt-watches', 'public');
            $imageUrl = 'storage/' . $path;
        }

        $watch->update([
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
            'image_url' => $imageUrl,
            'stock' => $request->stock,
            'is_active' => $request->boolean('is_active'),
        ]);

        AuditLogService::log(
            $request->user(),
            'update',
            'prebuilt_watch',
            $watch->id,
            $old,
            $watch->fresh()->toArray()
        );

        return response()->json([
            'message' => 'Előre összeállított óra sikeresen módosítva.',
            'watch' => $watch->fresh()
        ]);
    }

    public function destroy(Request $request, $id)
    {
        $watch = PrebuiltWatch::findOrFail($id);

        if ($watch->orderItems()->exists()) {
            return response()->json([
                'message' => 'Az óra már szerepel rendelésben, ezért nem törölhető fizikailag.'
            ], 409);
        }

        $old = $watch->toArray();

        if ($watch->image_url && str_starts_with($watch->image_url, 'storage/')) {
            $oldPath = str_replace('storage/', '', $watch->image_url);
            Storage::disk('public')->delete($oldPath);
        }

        $watch->delete();

        AuditLogService::log(
            $request->user(),
            'delete',
            'prebuilt_watch',
            $id,
            $old,
            null
        );

        return response()->json([
            'message' => 'Előre összeállított óra sikeresen törölve.'
        ]);
    }
}