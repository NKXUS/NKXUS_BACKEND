<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Service;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class ServiceController extends Controller
{
    /**
     * Display all services.
     */
    public function index(Request $request): JsonResponse
    {
        $services = Service::query()
            ->with('category')
            ->when(
                $request->filled('service_category_id'),
                function ($query) use ($request) {
                    $query->where(
                        'service_category_id',
                        $request->integer('service_category_id')
                    );
                }
            )
            ->when(
                $request->has('status'),
                function ($query) use ($request) {
                    $query->where(
                        'status',
                        $request->boolean('status')
                    );
                }
            )
            ->orderBy('service_category_id')
            ->orderBy('name')
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Services retrieved successfully.',
            'data' => $services,
        ]);
    }

    /**
     * Create a new service.
     */
    public function store(Request $request): JsonResponse
    {
        $generatedSlug = Str::slug(
            $request->input('slug') ?: $request->input('name', '')
        );

        $request->merge([
            'slug' => $generatedSlug,
        ]);

        $validated = $request->validate([
            'service_category_id' => [
                'required',
                'integer',
                'exists:service_categories,id',
            ],

            'name' => [
                'required',
                'string',
                'max:150',
            ],

            'slug' => [
                'required',
                'string',
                'max:180',
                'unique:services,slug',
            ],

            'description' => [
                'nullable',
                'string',
                'max:5000',
            ],

            'minimum_quantity' => [
                'required',
                'integer',
                'min:1',
            ],

            'maximum_quantity' => [
                'required',
                'integer',
                'gte:minimum_quantity',
            ],

            'rate_per_1000' => [
                'required',
                'numeric',
                'min:0',
            ],

            'old_price' => [
                'nullable',
                'numeric',
                'min:0',
            ],

            'delivery_time' => [
                'nullable',
                'string',
                'max:100',
            ],

            'quality' => [
                'nullable',
                'string',
                'max:100',
            ],

            'provider_service_id' => [
                'nullable',
                'string',
                'max:100',
            ],

            'status' => [
                'nullable',
                'boolean',
            ],
        ]);

        $validated['status'] = $validated['status'] ?? true;

        $service = Service::create($validated);

        $service->load('category');

        return response()->json([
            'success' => true,
            'message' => 'Service created successfully.',
            'data' => $service,
        ], 201);
    }

    /**
     * Display one service.
     */
    public function show(Service $service): JsonResponse
    {
        $service->load('category');

        return response()->json([
            'success' => true,
            'message' => 'Service retrieved successfully.',
            'data' => $service,
        ]);
    }

    /**
     * Update a service.
     */
    public function update(
        Request $request,
        Service $service
    ): JsonResponse {
        if ($request->has('name') || $request->has('slug')) {
            $generatedSlug = Str::slug(
                $request->input('slug')
                ?: $request->input('name', $service->name)
            );

            $request->merge([
                'slug' => $generatedSlug,
            ]);
        }

        $validated = $request->validate([
            'service_category_id' => [
                'sometimes',
                'required',
                'integer',
                'exists:service_categories,id',
            ],

            'name' => [
                'sometimes',
                'required',
                'string',
                'max:150',
            ],

            'slug' => [
                'sometimes',
                'required',
                'string',
                'max:180',
                Rule::unique('services', 'slug')
                    ->ignore($service->id),
            ],

            'description' => [
                'sometimes',
                'nullable',
                'string',
                'max:5000',
            ],

            'minimum_quantity' => [
                'sometimes',
                'required',
                'integer',
                'min:1',
            ],

            'maximum_quantity' => [
                'sometimes',
                'required',
                'integer',
                'min:1',
            ],

            'rate_per_1000' => [
                'sometimes',
                'required',
                'numeric',
                'min:0',
            ],

            'old_price' => [
                'sometimes',
                'nullable',
                'numeric',
                'min:0',
            ],

            'delivery_time' => [
                'sometimes',
                'nullable',
                'string',
                'max:100',
            ],

            'quality' => [
                'sometimes',
                'nullable',
                'string',
                'max:100',
            ],

            'provider_service_id' => [
                'sometimes',
                'nullable',
                'string',
                'max:100',
            ],

            'status' => [
                'sometimes',
                'boolean',
            ],
        ]);

        $minimumQuantity = $validated['minimum_quantity']
            ?? $service->minimum_quantity;

        $maximumQuantity = $validated['maximum_quantity']
            ?? $service->maximum_quantity;

        if ($maximumQuantity < $minimumQuantity) {
            return response()->json([
                'message' => 'The maximum quantity must be greater than or equal to the minimum quantity.',
                'errors' => [
                    'maximum_quantity' => [
                        'The maximum quantity must be greater than or equal to the minimum quantity.',
                    ],
                ],
            ], 422);
        }

        $service->update($validated);

        $updatedService = $service
            ->fresh()
            ->load('category');

        return response()->json([
            'success' => true,
            'message' => 'Service updated successfully.',
            'data' => $updatedService,
        ]);
    }

    /**
     * Delete a service.
     */
    public function destroy(Service $service): JsonResponse
    {
        $service->delete();

        return response()->json([
            'success' => true,
            'message' => 'Service deleted successfully.',
        ]);
    }
}