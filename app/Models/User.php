<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens;
    use HasFactory;
    use Notifiable;

    /**
     * Imported database table.
     */
    protected $table = 'smmusers';

    /**
     * Primary key column.
     */
    protected $primaryKey = 'id';

    /**
     * The smmusers table contains only:
     * id, email and password.
     */
    public $timestamps = false;

    /**
     * Fields allowed during registration.
     */
    protected $fillable = [
        'email',
        'password',
    ];

    /**
     * Hide password from API responses.
     */
    protected $hidden = [
        'password',
    ];
}