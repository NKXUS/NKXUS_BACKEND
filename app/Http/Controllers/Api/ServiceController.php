<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Service;
use App\Models\ServiceCategory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class ServiceController extends Controller
{
    /**
     * Display active services.
     *
     * Available filters:
     * GET /api/services
     * GET /api/services?platform=Instagram
     * GET /api/services?category_id=2
     * GET /api/services?category=instagram-likes
     * GET /api/services?quality_type=high_quality
     * GET /api/services?is_featured=1
     */
    public function index(Request $request): JsonResponse
    {
        $services = Service::query()
            ->active()
            ->whereHas('category', function ($query) {
                $query->where('is_active', true);
            })
            ->with('category')
            ->when(
                $request->filled('platform'),
                function ($query) use ($request) {
                    $query->where(
                        'platform',
                        $request->string('platform')->trim()->toString()
                    );
                }
            )
            ->when(
                $request->filled('category_id'),
                function ($query) use ($request) {
                    $query->where(
                        'category_id',
                        (int) $request->input('category_id')
                    );
                }
            )
            ->when(
                $request->filled('category'),
                function ($query) use ($request) {
                    $identifier = $request
                        ->string('category')
                        ->trim()
                        ->toString();

                    $query->whereHas(
                        'category',
                        function ($categoryQuery) use ($identifier) {
                            $categoryQuery->where(
                                function ($identifierQuery) use ($identifier) {
                                    $identifierQuery->where(
                                        'slug',
                                        $identifier
                                    );

                                    if (ctype_digit($identifier)) {
                                        $identifierQuery->orWhere(
                                            'id',
                                            (int) $identifier
                                        );
                                    }
                                }
                            );
                        }
                    );
                }
            )
            ->when(
                $request->filled('quality_type'),
                function ($query) use ($request) {
                    $query->where(
                        'quality_type',
                        $request->string('quality_type')->trim()->toString()
                    );
                }
            )
            ->when(
                $request->has('is_featured'),
                function ($query) use ($request) {
                    $query->where(
                        'is_featured',
                        $request->boolean('is_featured')
                    );
                }
            )
            ->orderBy('category_id')
            ->orderByRaw("
                CASE quality_type
                    WHEN 'high_quality' THEN 1
                    WHEN 'premium' THEN 2
                    ELSE 3
                END
            ")
            ->orderBy('name')
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Services retrieved successfully.',
            'data' => $services,
        ]);
    }

    /**
     * Store a new service.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'category_id' => [
                'required',
                'integer',
                Rule::exists('service_categories', 'id'),
            ],

            'name' => [
                'required',
                'string',
                'max:255',
            ],

            'slug' => [
                'nullable',
                'string',
                'max:191',
                Rule::unique('services', 'slug'),
            ],

            'rate_per_1000' => [
                'required',
                'numeric',
                'min:0.01',
            ],

            'min_order' => [
                'nullable',
                'integer',
                Rule::in(Service::DEFAULT_QUANTITIES),
            ],

            'max_order' => [
                'nullable',
                'integer',
                Rule::in(Service::DEFAULT_QUANTITIES),
            ],

            'avg_time' => [
                'nullable',
                'string',
                'max:255',
            ],

            'description' => [
                'nullable',
                'string',
            ],

            'quality_type' => [
                'required',
                Rule::in([
                    'high_quality',
                    'premium',
                ]),
            ],

            'allowed_quantities' => [
                'nullable',
                'array',
                'min:1',
            ],

            'allowed_quantities.*' => [
                'required',
                'integer',
                Rule::in(Service::DEFAULT_QUANTITIES),
            ],

            'is_active' => [
                'nullable',
                'boolean',
            ],

            'is_featured' => [
                'nullable',
                'boolean',
            ],
        ]);

        $category = ServiceCategory::query()
            ->active()
            ->find($validated['category_id']);

        if (!$category) {
            return response()->json([
                'success' => false,
                'message' => 'The selected category is inactive or does not exist.',
            ], 422);
        }

        $minimumQuantity = (int) (
            $validated['min_order'] ?? 50
        );

        $maximumQuantity = (int) (
            $validated['max_order'] ?? 10000
        );

        if ($minimumQuantity > $maximumQuantity) {
            return response()->json([
                'success' => false,
                'message' => 'Minimum order cannot be greater than maximum order.',
            ], 422);
        }

        $allowedQuantities = $validated['allowed_quantities']
            ?? Service::DEFAULT_QUANTITIES;

        $allowedQuantities = $this->prepareAllowedQuantities(
            $allowedQuantities,
            $minimumQuantity,
            $maximumQuantity
        );

        if (empty($allowedQuantities)) {
            return response()->json([
                'success' => false,
                'message' => 'At least one allowed quantity is required.',
            ], 422);
        }

        $slug = $validated['slug']
            ?? Str::slug($validated['name']);

        $slug = $this->createUniqueSlug($slug);

        $service = DB::transaction(function () use (
            $validated,
            $category,
            $minimumQuantity,
            $maximumQuantity,
            $allowedQuantities,
            $slug
        ) {
            return Service::create([
                'category_id' => $category->id,
                'name' => $validated['name'],
                'rate_per_1000' => $validated['rate_per_1000'],
                'min_order' => $minimumQuantity,
                'max_order' => $maximumQuantity,
                'avg_time' => $validated['avg_time'] ?? null,
                'description' => $validated['description'] ?? null,
                'platform' => $category->platform,
                'is_active' => $validated['is_active'] ?? true,
                'is_featured' => $validated['is_featured'] ?? false,
                'slug' => $slug,
                'quality_type' => $validated['quality_type'],
                'allowed_quantities' => $allowedQuantities,
            ]);
        });

        return response()->json([
            'success' => true,
            'message' => 'Service created successfully.',
            'data' => $service->load('category'),
        ], 201);
    }

    /**
     * Display one active service.
     *
     * Identifier can be:
     * - Service ID
     * - Service slug
     */
    public function show(string $identifier): JsonResponse
    {
        $service = Service::query()
            ->active()
            ->whereHas('category', function ($query) {
                $query->where('is_active', true);
            })
            ->where(function ($query) use ($identifier) {
                $query->where('slug', $identifier);

                if (ctype_digit($identifier)) {
                    $query->orWhere('id', (int) $identifier);
                }
            })
            ->with('category')
            ->first();

        if (!$service) {
            return response()->json([
                'success' => false,
                'message' => 'Service not found.',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Service retrieved successfully.',
            'data' => $service,
        ]);
    }

    /**
     * Update an existing service.
     */
    public function update(
        Request $request,
        Service $service
    ): JsonResponse {
        $validated = $request->validate([
            'category_id' => [
                'sometimes',
                'required',
                'integer',
                Rule::exists('service_categories', 'id'),
            ],

            'name' => [
                'sometimes',
                'required',
                'string',
                'max:255',
            ],

            'slug' => [
                'sometimes',
                'nullable',
                'string',
                'max:191',
                Rule::unique('services', 'slug')
                    ->ignore($service->id),
            ],

            'rate_per_1000' => [
                'sometimes',
                'required',
                'numeric',
                'min:0.01',
            ],

            'min_order' => [
                'sometimes',
                'integer',
                Rule::in(Service::DEFAULT_QUANTITIES),
            ],

            'max_order' => [
                'sometimes',
                'integer',
                Rule::in(Service::DEFAULT_QUANTITIES),
            ],

            'avg_time' => [
                'sometimes',
                'nullable',
                'string',
                'max:255',
            ],

            'description' => [
                'sometimes',
                'nullable',
                'string',
            ],

            'quality_type' => [
                'sometimes',
                'required',
                Rule::in([
                    'high_quality',
                    'premium',
                ]),
            ],

            'allowed_quantities' => [
                'sometimes',
                'array',
                'min:1',
            ],

            'allowed_quantities.*' => [
                'required',
                'integer',
                Rule::in(Service::DEFAULT_QUANTITIES),
            ],

            'is_active' => [
                'sometimes',
                'boolean',
            ],

            'is_featured' => [
                'sometimes',
                'boolean',
            ],
        ]);

        $categoryId = $validated['category_id']
            ?? $service->category_id;

        $category = ServiceCategory::query()
            ->find($categoryId);

        if (!$category) {
            return response()->json([
                'success' => false,
                'message' => 'The selected category does not exist.',
            ], 422);
        }

        $minimumQuantity = (int) (
            $validated['min_order']
            ?? $service->min_order
        );

        $maximumQuantity = (int) (
            $validated['max_order']
            ?? $service->max_order
        );

        if ($minimumQuantity > $maximumQuantity) {
            return response()->json([
                'success' => false,
                'message' => 'Minimum order cannot be greater than maximum order.',
            ], 422);
        }

        $allowedQuantities = array_key_exists(
            'allowed_quantities',
            $validated
        )
            ? $validated['allowed_quantities']
            : $service->quantity_options;

        $allowedQuantities = $this->prepareAllowedQuantities(
            $allowedQuantities,
            $minimumQuantity,
            $maximumQuantity
        );

        if (empty($allowedQuantities)) {
            return response()->json([
                'success' => false,
                'message' => 'At least one allowed quantity is required.',
            ], 422);
        }

        if (array_key_exists('slug', $validated)) {
            $newSlug = $validated['slug'];

            if (blank($newSlug)) {
                $newSlug = Str::slug(
                    $validated['name'] ?? $service->name
                );
            }

            $validated['slug'] = $this->createUniqueSlug(
                $newSlug,
                $service->id
            );
        }

        DB::transaction(function () use (
            $service,
            $validated,
            $category,
            $minimumQuantity,
            $maximumQuantity,
            $allowedQuantities
        ) {
            $service->update([
                'category_id' => $category->id,

                'name' => $validated['name']
                    ?? $service->name,

                'rate_per_1000' => $validated['rate_per_1000']
                    ?? $service->rate_per_1000,

                'min_order' => $minimumQuantity,

                'max_order' => $maximumQuantity,

                'avg_time' => array_key_exists(
                    'avg_time',
                    $validated
                )
                    ? $validated['avg_time']
                    : $service->avg_time,

                'description' => array_key_exists(
                    'description',
                    $validated
                )
                    ? $validated['description']
                    : $service->description,

                'platform' => $category->platform,

                'is_active' => $validated['is_active']
                    ?? $service->is_active,

                'is_featured' => $validated['is_featured']
                    ?? $service->is_featured,

                'slug' => $validated['slug']
                    ?? $service->slug,

                'quality_type' => $validated['quality_type']
                    ?? $service->quality_type,

                'allowed_quantities' => $allowedQuantities,
            ]);
        });

        return response()->json([
            'success' => true,
            'message' => 'Service updated successfully.',
            'data' => $service
                ->fresh()
                ->load('category'),
        ]);
    }

    /**
     * Delete a service only when it has no connected orders.
     */
    public function destroy(Service $service): JsonResponse
    {
        if ($service->orders()->exists()) {
            return response()->json([
                'success' => false,
                'message' => 'This service has connected orders. Set is_active to false instead of deleting it.',
            ], 422);
        }

        DB::transaction(function () use ($service) {
            $service->delete();
        });

        return response()->json([
            'success' => true,
            'message' => 'Service deleted successfully.',
        ]);
    }

    /**
     * Validate, sort and filter allowed quantities.
     */
    private function prepareAllowedQuantities(
        array $quantities,
        int $minimumQuantity,
        int $maximumQuantity
    ): array {
        $quantities = array_map(
            'intval',
            $quantities
        );

        $quantities = array_filter(
            $quantities,
            function (int $quantity) use (
                $minimumQuantity,
                $maximumQuantity
            ) {
                return in_array(
                    $quantity,
                    Service::DEFAULT_QUANTITIES,
                    true
                )
                    && $quantity >= $minimumQuantity
                    && $quantity <= $maximumQuantity;
            }
        );

        $quantities = array_values(
            array_unique($quantities)
        );

        sort($quantities);

        return $quantities;
    }

    /**
     * Generate a unique service slug.
     */
    private function createUniqueSlug(
        string $slug,
        ?int $ignoreId = null
    ): string {
        $baseSlug = Str::slug($slug);

        if ($baseSlug === '') {
            $baseSlug = 'service';
        }

        $finalSlug = $baseSlug;
        $counter = 1;

        while (
            Service::query()
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

