<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class AdminMiddleware
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();

        if (!$user) {
            return response()->json([
                'message' => 'Bejelentkezés szükséges.'
            ], 401);
        }

        if ($user->role !== 'admin') {
            return response()->json([
                'message' => 'Nincs jogosultságod ehhez a művelethez.'
            ], 403);
        }

        return $next($request);
    }
}