<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ServiceCategory extends Model
{
    use HasFactory;

    /**
     * Imported database table name.
     */
    protected $table = 'service_categories';

    /**
     * Primary key column.
     */
    protected $primaryKey = 'id';

    protected $fillable = [
        'name',
        'slug',
        'description',
        'icon',
        'status',
        'sort_order',
    ];

    protected function casts(): array
    {
        return [
            'id' => 'integer',
            'status' => 'boolean',
            'sort_order' => 'integer',
        ];
    }

    /**
     * A service category contains many services.
     */
    public function services(): HasMany
    {
        return $this->hasMany(
            Service::class,
            'service_category_id',
            'id'
        );
    }
}