<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ServiceCategoryController;
use App\Http\Controllers\Api\ServiceController;
use App\Http\Controllers\Api\SupportTicketController;
use Illuminate\Support\Facades\Route;

Route::get('/test', function () {
    return response()->json([
        'success' => true,
        'message' => 'Laravel API is working.',
    ]);
});

/*
|--------------------------------------------------------------------------
| Authentication
|--------------------------------------------------------------------------
*/

Route::post('/register', [
    AuthController::class,
    'register',
]);

Route::post('/login', [
    AuthController::class,
    'login',
]);

/*
|--------------------------------------------------------------------------
| Contact Us
|--------------------------------------------------------------------------
*/

Route::post('/support-tickets', [
    SupportTicketController::class,
    'store',
]);

/*
|--------------------------------------------------------------------------
| Public services
|--------------------------------------------------------------------------
*/

Route::get('/service-categories', [
    ServiceCategoryController::class,
    'index',
]);

Route::get('/service-categories/{serviceCategory}', [
    ServiceCategoryController::class,
    'show',
]);

Route::get('/services', [
    ServiceController::class,
    'index',
]);

Route::get('/services/{service}', [
    ServiceController::class,
    'show',
]);

/*
|--------------------------------------------------------------------------
| Protected routes
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [
        AuthController::class,
        'user',
    ]);

    Route::post('/logout', [
        AuthController::class,
        'logout',
    ]);

    Route::post('/logout-all', [
        AuthController::class,
        'logoutAll',
    ]);
});