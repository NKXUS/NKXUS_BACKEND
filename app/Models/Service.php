<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Service extends Model
{
    use HasFactory;

    protected $fillable = [
        'service_category_id',
        'name',
        'slug',
        'description',
        'minimum_quantity',
        'maximum_quantity',
        'rate_per_1000',
        'old_price',
        'delivery_time',
        'quality',
        'provider_service_id',
        'status',
    ];

    protected function casts(): array
    {
        return [
            'minimum_quantity' => 'integer',
            'maximum_quantity' => 'integer',
            'rate_per_1000' => 'decimal:2',
            'old_price' => 'decimal:2',
            'status' => 'boolean',
        ];
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(
            ServiceCategory::class,
            'service_category_id'
        );
    }
}