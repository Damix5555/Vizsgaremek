<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\AuditLogService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'username' => 'required|string|max:50|unique:users,username',
            'email' => 'required|email|max:100|unique:users,email',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $user = User::create([
            'username' => $request->username,
            'email' => strtolower($request->email),
            'password' => Hash::make($request->password),
            'role' => 'user',
        ]);

        $token = $user->createToken('auth_token', ['user'])->plainTextToken;

        AuditLogService::log(
            $user,
            'register',
            'user',
            $user->id,
            null,
            [
                'username' => $user->username,
                'email' => $user->email,
                'role' => $user->role,
            ]
        );

        return response()->json([
            'message' => 'Sikeres regisztráció.',
            'token' => $token,
            'user' => $user,
        ], 201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', strtolower($request->email))->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['Hibás email vagy jelszó.']
            ]);
        }

        $abilities = $user->role === 'admin' ? ['admin', 'user'] : ['user'];

        $user->tokens()->delete();

        $token = $user->createToken('auth_token', $abilities)->plainTextToken;

        AuditLogService::log(
            $user,
            'login',
            'user',
            $user->id,
            null,
            [
                'email' => $user->email,
                'role' => $user->role,
            ]
        );

        return response()->json([
            'message' => 'Sikeres bejelentkezés.',
            'token' => $token,
            'user' => $user,
        ]);
    }

    public function me(Request $request)
    {
        return response()->json($request->user());
    }

    public function logout(Request $request)
    {
        $user = $request->user();

        if ($user && $request->user()->currentAccessToken()) {
            AuditLogService::log(
                $user,
                'logout',
                'user',
                $user->id,
                null,
                [
                    'email' => $user->email,
                ]
            );

            $request->user()->currentAccessToken()->delete();
        }

        return response()->json([
            'message' => 'Sikeres kijelentkezés.'
        ]);
    }
}