<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServiceCategory extends Model
{
    use HasFactory;

    protected $table = 'service_categories';

    protected $fillable = [
        'name',
        'platform',
        'icon_url',
        'slug',
        'sort_order',
        'is_active',
    ];

    protected $casts = [
        'id' => 'integer',
        'sort_order' => 'integer',
        'is_active' => 'boolean',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Return only active categories.
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Services belonging to this category.
     */
    public function services()
    {
        return $this->hasMany(
            Service::class,
            'category_id',
            'id'
        );
    }

    /**
     * Only active services belonging to this category.
     */
    public function activeServices()
    {
        return $this->hasMany(
            Service::class,
            'category_id',
            'id'
        )->where('is_active', true);
    }
}

