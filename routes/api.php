
<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\ServiceCategoryController;
use App\Http\Controllers\Api\ServiceController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Test Route
|--------------------------------------------------------------------------
*/

Route::get('/test', function () {
    return response()->json([
        'success' => true,
        'message' => 'NKXUS API is working successfully.',
    ]);
});

/*
|--------------------------------------------------------------------------
| Authentication Routes
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
| Contact / Support Ticket Route
|--------------------------------------------------------------------------
*/

Route::post('/support-tickets', function (Request $request) {
    $validated = $request->validate([
        'full_name' => [
            'required',
            'string',
            'max:255',
        ],

        'email' => [
            'required',
            'email',
            'max:255',
        ],

        'subject' => [
            'required',
            'string',
            'max:1000',
        ],
    ]);

    $ticketId = DB::table('support_tickets')->insertGetId([
        'user_id' => null,
        'name' => $validated['full_name'],
        'full_name' => $validated['full_name'],
        'email' => $validated['email'],
        'subject' => $validated['subject'],
        'message' => $validated['subject'],
        'created_at' => now(),
        'updated_at' => now(),
    ]);

    return response()->json([
        'success' => true,
        'message' => 'Your support request was submitted successfully.',
        'data' => [
            'id' => $ticketId,
        ],
    ], 201);
});

/*
|--------------------------------------------------------------------------
| Public Service Category Routes
|--------------------------------------------------------------------------
|
| Customers can view platforms, categories and their active services
| without signing in.
|
*/

Route::get('/service-categories', [
    ServiceCategoryController::class,
    'index',
]);

Route::get('/service-categories/{identifier}', [
    ServiceCategoryController::class,
    'show',
]);

/*
|--------------------------------------------------------------------------
| Public Service Routes
|--------------------------------------------------------------------------
|
| Customers can view High Quality and Premium services, quantity
| options and calculated package prices without signing in.
|
*/

Route::get('/services', [
    ServiceController::class,
    'index',
]);

Route::get('/services/{identifier}', [
    ServiceController::class,
    'show',
]);

/*
|--------------------------------------------------------------------------
| Protected Routes
|--------------------------------------------------------------------------
|
| These routes require a valid Laravel Sanctum token.
|
*/

Route::middleware('auth:sanctum')->group(function () {
    /*
    |--------------------------------------------------------------------------
    | Logged-in User
    |--------------------------------------------------------------------------
    */

    Route::get('/user', function (Request $request) {
        return response()->json([
            'success' => true,
            'message' => 'User retrieved successfully.',
            'data' => $request->user(),
        ]);
    });

    Route::post('/logout', [
        AuthController::class,
        'logout',
    ]);

    Route::post('/logout-all', [
        AuthController::class,
        'logoutAll',
    ]);

    /*
    |--------------------------------------------------------------------------
    | Customer Order Routes
    |--------------------------------------------------------------------------
    */

    Route::get('/orders', [
        OrderController::class,
        'index',
    ]);

    Route::post('/orders', [
        OrderController::class,
        'store',
    ]);

    Route::get('/orders/{order}', [
        OrderController::class,
        'show',
    ])->whereNumber('order');

    Route::patch('/orders/{order}/cancel', [
        OrderController::class,
        'cancel',
    ])->whereNumber('order');
});

