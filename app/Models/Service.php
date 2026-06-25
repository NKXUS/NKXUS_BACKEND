<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    /**
     * Quantities allowed in the NKXUS frontend.
     */
    public const DEFAULT_QUANTITIES = [
        50,
        100,
        250,
        500,
        1000,
        2500,
        5000,
        10000,
    ];

    protected $table = 'services';

    protected $fillable = [
        'category_id',
        'name',
        'rate_per_1000',
        'min_order',
        'max_order',
        'avg_time',
        'description',
        'platform',
        'is_active',
        'is_featured',
        'slug',
        'quality_type',
        'allowed_quantities',
    ];

    protected $casts = [
        'id' => 'integer',
        'category_id' => 'integer',
        'rate_per_1000' => 'decimal:2',
        'min_order' => 'integer',
        'max_order' => 'integer',
        'is_active' => 'boolean',
        'is_featured' => 'boolean',
        'allowed_quantities' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    protected $appends = [
        'quantity_options',
        'package_prices',
    ];

    /**
     * Return only active services.
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Return only featured services.
     */
    public function scopeFeatured($query)
    {
        return $query->where('is_featured', true);
    }

    /**
     * Return High Quality services.
     */
    public function scopeHighQuality($query)
    {
        return $query->where('quality_type', 'high_quality');
    }

    /**
     * Return Premium services.
     */
    public function scopePremium($query)
    {
        return $query->where('quality_type', 'premium');
    }

    /**
     * Filter services by platform.
     */
    public function scopePlatform($query, string $platform)
    {
        return $query->where('platform', $platform);
    }

    /**
     * Category belonging to this service.
     */
    public function category()
    {
        return $this->belongsTo(
            ServiceCategory::class,
            'category_id',
            'id'
        );
    }

    /**
     * Orders created for this service.
     */
    public function orders()
    {
        return $this->hasMany(
            Order::class,
            'service_id',
            'id'
        );
    }

    /**
     * Get the allowed quantity options.
     */
    public function getQuantityOptionsAttribute(): array
    {
        $quantities = $this->allowed_quantities;

        if (!is_array($quantities) || empty($quantities)) {
            $quantities = self::DEFAULT_QUANTITIES;
        }

        $minimum = (int) $this->min_order;
        $maximum = (int) $this->max_order;

        return array_values(
            array_filter(
                array_map('intval', $quantities),
                function (int $quantity) use ($minimum, $maximum) {
                    return $quantity >= $minimum
                        && $quantity <= $maximum;
                }
            )
        );
    }

    /**
     * Get the price for every allowed quantity.
     */
    public function getPackagePricesAttribute(): array
    {
        $prices = [];

        foreach ($this->quantity_options as $quantity) {
            $prices[] = [
                'quantity' => $quantity,
                'price' => $this->calculatePrice($quantity),
            ];
        }

        return $prices;
    }

    /**
     * Calculate the total price for a quantity.
     */
    public function calculatePrice(int $quantity): float
    {
        $rate = (float) $this->rate_per_1000;

        return round(($rate * $quantity) / 1000, 2);
    }

    /**
     * Check whether a quantity is allowed for this service.
     */
    public function isQuantityAllowed(int $quantity): bool
    {
        return in_array(
            $quantity,
            $this->quantity_options,
            true
        );
    }
}

