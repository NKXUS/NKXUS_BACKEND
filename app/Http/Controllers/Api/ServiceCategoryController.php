<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ServiceCategory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class ServiceCategoryController extends Controller
{
    /**
     * Display all active service categories.
     *
     * Example:
     * GET /api/service-categories
     * GET /api/service-categories?platform=Instagram
     */
    public function index(Request $request): JsonResponse
    {
        $categories = ServiceCategory::query()
            ->active()
            ->when(
                $request->filled('platform'),
                function ($query) use ($request) {
                    $query->where(
                        'platform',
                        $request->string('platform')->trim()->toString()
                    );
                }
            )
            ->with([
                'activeServices' => function ($query) {
                    $query
                        ->orderByRaw("
                            CASE quality_type
                                WHEN 'high_quality' THEN 1
                                WHEN 'premium' THEN 2
                                ELSE 3
                            END
                        ")
                        ->orderBy('name');
                },
            ])
            ->orderBy('sort_order')
            ->orderBy('name')
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Service categories retrieved successfully.',
            'data' => $categories,
        ]);
    }

    /**
     * Store a new service category.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => [
                'required',
                'string',
                'max:255',
            ],

            'platform' => [
                'required',
                'string',
                'max:255',
            ],

            'icon_url' => [
                'nullable',
                'url',
                'max:255',
            ],

            'slug' => [
                'nullable',
                'string',
                'max:191',
                Rule::unique('service_categories', 'slug'),
            ],

            'sort_order' => [
                'nullable',
                'integer',
                'min:0',
            ],

            'is_active' => [
                'nullable',
                'boolean',
            ],
        ]);

        $slug = $validated['slug']
            ?? Str::slug($validated['platform'] . '-' . $validated['name']);

        $slug = $this->createUniqueSlug($slug);

        $category = ServiceCategory::create([
            'name' => $validated['name'],
            'platform' => $validated['platform'],
            'icon_url' => $validated['icon_url'] ?? null,
            'slug' => $slug,
            'sort_order' => $validated['sort_order'] ?? 0,
            'is_active' => $validated['is_active'] ?? true,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Service category created successfully.',
            'data' => $category,
        ], 201);
    }

    /**
     * Display one active service category.
     *
     * Identifier can be:
     * - Category ID
     * - Category slug
     */
    public function show(string $identifier): JsonResponse
    {
        $category = ServiceCategory::query()
            ->active()
            ->where(function ($query) use ($identifier) {
                $query->where('slug', $identifier);

                if (ctype_digit($identifier)) {
                    $query->orWhere('id', (int) $identifier);
                }
            })
            ->with([
                'activeServices' => function ($query) {
                    $query
                        ->orderByRaw("
                            CASE quality_type
                                WHEN 'high_quality' THEN 1
                                WHEN 'premium' THEN 2
                                ELSE 3
                            END
                        ")
                        ->orderBy('name');
                },
            ])
            ->first();

        if (!$category) {
            return response()->json([
                'success' => false,
                'message' => 'Service category not found.',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Service category retrieved successfully.',
            'data' => $category,
        ]);
    }

    /**
     * Update a service category.
     */
    public function update(
        Request $request,
        ServiceCategory $serviceCategory
    ): JsonResponse {
        $validated = $request->validate([
            'name' => [
                'sometimes',
                'required',
                'string',
                'max:255',
            ],

            'platform' => [
                'sometimes',
                'required',
                'string',
                'max:255',
            ],

            'icon_url' => [
                'sometimes',
                'nullable',
                'url',
                'max:255',
            ],

            'slug' => [
                'sometimes',
                'nullable',
                'string',
                'max:191',
                Rule::unique('service_categories', 'slug')
                    ->ignore($serviceCategory->id),
            ],

            'sort_order' => [
                'sometimes',
                'integer',
                'min:0',
            ],

            'is_active' => [
                'sometimes',
                'boolean',
            ],
        ]);

        if (array_key_exists('slug', $validated)) {
            $newSlug = $validated['slug'];

            if (blank($newSlug)) {
                $newSlug = Str::slug(
                    ($validated['platform'] ?? $serviceCategory->platform)
                    . '-'
                    . ($validated['name'] ?? $serviceCategory->name)
                );
            }

            $validated['slug'] = $this->createUniqueSlug(
                $newSlug,
                $serviceCategory->id
            );
        }

        $serviceCategory->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Service category updated successfully.',
            'data' => $serviceCategory->fresh(),
        ]);
    }

    /**
     * Delete a category only when it has no connected services.
     */
    public function destroy(
        ServiceCategory $serviceCategory
    ): JsonResponse {
        if ($serviceCategory->services()->exists()) {
            return response()->json([
                'success' => false,
                'message' => 'This category has connected services. Set is_active to false instead of deleting it.',
            ], 422);
        }

        DB::transaction(function () use ($serviceCategory) {
            $serviceCategory->delete();
        });

        return response()->json([
            'success' => true,
            'message' => 'Service category deleted successfully.',
        ]);
    }

    /**
     * Generate a unique slug.
     */
    private function createUniqueSlug(
        string $slug,
        ?int $ignoreId = null
    ): string {
        $baseSlug = Str::slug($slug);

        if ($baseSlug === '') {
            $baseSlug = 'service-category';
        }

        $finalSlug = $baseSlug;
        $counter = 1;

        while (
            ServiceCategory::query()
                ->when(
                    $ignoreId !== null,
                    function ($query) use ($ignoreId) {
                        $query->where('id', '!=', $ignoreId);
                    }
                )
                ->where('slug', $finalSlug)
                ->exists()
        ) {
            $finalSlug = $baseSlug . '-' . $counter;
            $counter++;
        }

        return $finalSlug;
    }
}

