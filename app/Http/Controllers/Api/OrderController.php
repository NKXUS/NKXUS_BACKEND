<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\Service;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class OrderController extends Controller
{
    /**
     * Return orders belonging to the logged-in user.
     *
     * Optional filters:
     * /api/orders?status=pending
     * /api/orders?limit=10
     */
    public function index(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'status' => [
                'nullable',
                Rule::in([
                    Order::STATUS_PENDING,
                    Order::STATUS_IN_PROGRESS,
                    Order::STATUS_COMPLETED,
                    Order::STATUS_PARTIAL,
                    Order::STATUS_CANCELLED,
                ]),
            ],

            'limit' => [
                'nullable',
                'integer',
                'min:1',
                'max:100',
            ],
        ]);

        $limit = $validated['limit'] ?? 50;

        $orders = Order::query()
            ->where('user_id', $request->user()->id)
            ->when(
                !empty($validated['status']),
                function ($query) use ($validated) {
                    $query->where(
                        'status',
                        $validated['status']
                    );
                }
            )
            ->with([
                'service.category',
            ])
            ->latest('id')
            ->limit($limit)
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Orders retrieved successfully.',
            'data' => $orders,
        ]);
    }

    /**
     * Create a new order.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'service_id' => [
                'required',
                'integer',
                Rule::exists('services', 'id'),
            ],

            'link' => [
                'required',
                'url',
                'max:255',
            ],

            'quantity' => [
                'required',
                'integer',
                Rule::in(Service::DEFAULT_QUANTITIES),
            ],
        ]);

        $service = Service::query()
            ->active()
            ->whereHas('category', function ($query) {
                $query->where('is_active', true);
            })
            ->with('category')
            ->find($validated['service_id']);

        if (!$service) {
            return response()->json([
                'success' => false,
                'message' => 'The selected service is inactive or does not exist.',
            ], 422);
        }

        $quantity = (int) $validated['quantity'];

        if (!$service->isQuantityAllowed($quantity)) {
            return response()->json([
                'success' => false,
                'message' => 'The selected quantity is not available for this service.',
                'allowed_quantities' => $service->quantity_options,
            ], 422);
        }

        $ratePerThousand = (float) $service->rate_per_1000;

        if ($ratePerThousand <= 0) {
            return response()->json([
                'success' => false,
                'message' => 'This service does not have a valid price.',
            ], 422);
        }

        $totalAmount = $service->calculatePrice($quantity);

        $order = DB::transaction(function () use (
            $request,
            $validated,
            $service,
            $quantity,
            $ratePerThousand,
            $totalAmount
        ) {
            return Order::create([
                'user_id' => $request->user()->id,
                'service_id' => $service->id,
                'link' => $validated['link'],
                'quantity' => $quantity,
                'charge' => $totalAmount,
                'start_count' => 0,
                'remains' => $quantity,
                'status' => Order::STATUS_PENDING,
                'rate_per_1000' => $ratePerThousand,
                'total_amount' => $totalAmount,
            ]);
        });

        return response()->json([
            'success' => true,
            'message' => 'Order created successfully.',
            'data' => $order->load([
                'service.category',
            ]),
        ], 201);
    }

    /**
     * Return one order belonging to the logged-in user.
     */
    public function show(
        Request $request,
        Order $order
    ): JsonResponse {
        if ($order->user_id !== $request->user()->id) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found.',
            ], 404);
        }

        $order->load([
            'service.category',
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Order retrieved successfully.',
            'data' => $order,
        ]);
    }

    /**
     * Cancel a pending order belonging to the logged-in user.
     */
    public function cancel(
        Request $request,
        Order $order
    ): JsonResponse {
        if ($order->user_id !== $request->user()->id) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found.',
            ], 404);
        }

        if (!$order->canBeCancelled()) {
            return response()->json([
                'success' => false,
                'message' => 'Only pending orders can be cancelled.',
            ], 422);
        }

        DB::transaction(function () use ($order) {
            $order->update([
                'status' => Order::STATUS_CANCELLED,
                'remains' => $order->quantity,
            ]);
        });

        return response()->json([
            'success' => true,
            'message' => 'Order cancelled successfully.',
            'data' => $order->fresh()->load([
                'service.category',
            ]),
        ]);
    }
}

