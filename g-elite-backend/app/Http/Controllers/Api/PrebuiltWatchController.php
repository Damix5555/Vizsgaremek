<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\PrebuiltWatch;

class PrebuiltWatchController extends Controller
{
    public function index()
    {
        $watches = PrebuiltWatch::where('is_active', 1)
            ->orderBy('name')
            ->get();

        return response()->json($watches);
    }

    public function show($id)
    {
        $watch = PrebuiltWatch::where('is_active', 1)->findOrFail($id);

        return response()->json($watch);
    }
}