<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ServiceCategory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class ServiceCategoryController extends Controller
{
    public function index(): JsonResponse
    {
        $categories = ServiceCategory::query()
            ->orderBy('sort_order')
            ->orderBy('name')
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Service categories retrieved successfully.',
            'data' => $categories,
        ]);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => [
                'required',
                'string',
                'max:100',
                'unique:service_categories,name',
            ],

            'slug' => [
                'nullable',
                'string',
                'max:120',
                'unique:service_categories,slug',
            ],

            'description' => [
                'nullable',
                'string',
                'max:2000',
            ],

            'icon' => [
                'nullable',
                'string',
                'max:255',
            ],

            'status' => [
                'nullable',
                'boolean',
            ],

            'sort_order' => [
                'nullable',
                'integer',
                'min:0',
            ],
        ]);

        $validated['slug'] = Str::slug(
            $validated['slug'] ?? $validated['name']
        );

        $validated['status'] = $validated['status'] ?? true;
        $validated['sort_order'] = $validated['sort_order'] ?? 0;

        $category = ServiceCategory::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Service category created successfully.',
            'data' => $category,
        ], 201);
    }

    public function show(ServiceCategory $serviceCategory): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => 'Service category retrieved successfully.',
            'data' => $serviceCategory,
        ]);
    }

    public function update(
        Request $request,
        ServiceCategory $serviceCategory
    ): JsonResponse {
        $validated = $request->validate([
            'name' => [
                'sometimes',
                'required',
                'string',
                'max:100',
                Rule::unique('service_categories', 'name')
                    ->ignore($serviceCategory->id),
            ],

            'slug' => [
                'sometimes',
                'nullable',
                'string',
                'max:120',
                Rule::unique('service_categories', 'slug')
                    ->ignore($serviceCategory->id),
            ],

            'description' => [
                'sometimes',
                'nullable',
                'string',
                'max:2000',
            ],

            'icon' => [
                'sometimes',
                'nullable',
                'string',
                'max:255',
            ],

            'status' => [
                'sometimes',
                'boolean',
            ],

            'sort_order' => [
                'sometimes',
                'integer',
                'min:0',
            ],
        ]);

        if (array_key_exists('slug', $validated)) {
            $validated['slug'] = Str::slug(
                $validated['slug'] ?: $serviceCategory->name
            );
        } elseif (array_key_exists('name', $validated)) {
            $validated['slug'] = Str::slug($validated['name']);
        }

        $serviceCategory->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Service category updated successfully.',
            'data' => $serviceCategory->fresh(),
        ]);
    }

    public function destroy(
        ServiceCategory $serviceCategory
    ): JsonResponse {
        $serviceCategory->delete();

        return response()->json([
            'success' => true,
            'message' => 'Service category deleted successfully.',
        ]);
    }
}