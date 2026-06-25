<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $table = 'smmusers';

    protected $fillable = [
        'email',
        'password',
    ];

    protected $hidden = [
        'password',
        'api_key',
        'api_token',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'balance' => 'decimal:2',
            'two_fa_enabled' => 'boolean',
            'created_at' => 'datetime',
            'updated_at' => 'datetime',
        ];
    }
}