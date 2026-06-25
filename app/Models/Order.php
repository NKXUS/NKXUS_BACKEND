<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    public const STATUS_PENDING = 'pending';
    public const STATUS_IN_PROGRESS = 'in_progress';
    public const STATUS_COMPLETED = 'completed';
    public const STATUS_PARTIAL = 'partial';
    public const STATUS_CANCELLED = 'cancelled';

    protected $table = 'orders';

    protected $fillable = [
        'user_id',
        'service_id',
        'link',
        'quantity',
        'charge',
        'start_count',
        'remains',
        'status',
        'rate_per_1000',
        'total_amount',
    ];

    protected $casts = [
        'id' => 'integer',
        'user_id' => 'integer',
        'service_id' => 'integer',
        'quantity' => 'integer',
        'charge' => 'decimal:2',
        'start_count' => 'integer',
        'remains' => 'integer',
        'rate_per_1000' => 'decimal:2',
        'total_amount' => 'decimal:2',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * User who created this order.
     */
    public function user()
    {
        return $this->belongsTo(
            User::class,
            'user_id',
            'id'
        );
    }

    /**
     * Service selected for this order.
     */
    public function service()
    {
        return $this->belongsTo(
            Service::class,
            'service_id',
            'id'
        );
    }

    /**
     * Return pending orders.
     */
    public function scopePending($query)
    {
        return $query->where(
            'status',
            self::STATUS_PENDING
        );
    }

    /**
     * Return in-progress orders.
     */
    public function scopeInProgress($query)
    {
        return $query->where(
            'status',
            self::STATUS_IN_PROGRESS
        );
    }

    /**
     * Return completed orders.
     */
    public function scopeCompleted($query)
    {
        return $query->where(
            'status',
            self::STATUS_COMPLETED
        );
    }

    /**
     * Return partial orders.
     */
    public function scopePartial($query)
    {
        return $query->where(
            'status',
            self::STATUS_PARTIAL
        );
    }

    /**
     * Return cancelled orders.
     */
    public function scopeCancelled($query)
    {
        return $query->where(
            'status',
            self::STATUS_CANCELLED
        );
    }

    /**
     * Return active orders.
     */
    public function scopeActive($query)
    {
        return $query->whereIn('status', [
            self::STATUS_PENDING,
            self::STATUS_IN_PROGRESS,
            self::STATUS_PARTIAL,
        ]);
    }

    /**
     * Check whether this order can be cancelled.
     */
    public function canBeCancelled(): bool
    {
        return $this->status === self::STATUS_PENDING;
    }
}
