<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\PrebuiltWatchController;
use App\Http\Controllers\Api\ConfigurationController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\Admin\ProductAdminController;
use App\Http\Controllers\Api\Admin\PrebuiltWatchAdminController;
use App\Http\Controllers\Api\Admin\AuditLogController;
use App\Http\Controllers\Api\Admin\OrderAdminController;

/*
|--------------------------------------------------------------------------
| Publik API útvonalak
|--------------------------------------------------------------------------
*/

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::prefix('products')->group(function () {
    Route::get('/', [ProductController::class, 'index']);
    Route::get('/type/{type}', [ProductController::class, 'byType']);
    Route::get('/{id}', [ProductController::class, 'show']);
});

Route::prefix('prebuilt-watches')->group(function () {
    Route::get('/', [PrebuiltWatchController::class, 'index']);
    Route::get('/{id}', [PrebuiltWatchController::class, 'show']);
});

/*
|--------------------------------------------------------------------------
| Autentikációt igénylő API útvonalak
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/me', [AuthController::class, 'me']);
    Route::post('/logout', [AuthController::class, 'logout']);

    Route::prefix('configurations')->group(function () {
        Route::post('/', [ConfigurationController::class, 'store']);
        Route::get('/mine', [ConfigurationController::class, 'myConfigurations']);
        Route::get('/{id}', [ConfigurationController::class, 'show']);
    });

    Route::prefix('orders')->group(function () {
        Route::post('/', [OrderController::class, 'store']);
        Route::get('/mine', [OrderController::class, 'myOrders']);
        Route::get('/{id}', [OrderController::class, 'show']);
    });

    /*
    |--------------------------------------------------------------------------
    | Admin API útvonalak
    |--------------------------------------------------------------------------
    */

    Route::prefix('admin')->middleware('admin')->group(function () {
        Route::put('/orders/{id}/status', [OrderController::class, 'updateStatus']);

        Route::prefix('products')->group(function () {
            Route::get('/', [ProductAdminController::class, 'index']);
            Route::post('/', [ProductAdminController::class, 'store']);
            Route::get('/{id}', [ProductAdminController::class, 'show']);
            Route::post('/{id}', [ProductAdminController::class, 'update']);
            Route::delete('/{id}', [ProductAdminController::class, 'destroy']);
        });

        Route::prefix('prebuilt-watches')->group(function () {
            Route::get('/', [PrebuiltWatchAdminController::class, 'index']);
            Route::post('/', [PrebuiltWatchAdminController::class, 'store']);
            Route::get('/{id}', [PrebuiltWatchAdminController::class, 'show']);
            Route::post('/{id}', [PrebuiltWatchAdminController::class, 'update']);
            Route::delete('/{id}', [PrebuiltWatchAdminController::class, 'destroy']);
        });
        
        Route::get('/audit-logs', [AuditLogController::class, 'index']);
        Route::get('/audit-logs/{id}', [AuditLogController::class, 'show']);   

        Route::prefix('orders')->group(function () {
        Route::get('/', [OrderAdminController::class, 'index']);
        Route::get('/{id}', [OrderAdminController::class, 'show']);
        Route::put('/{id}/status', [OrderAdminController::class, 'updateStatus']);
        });
    });
});