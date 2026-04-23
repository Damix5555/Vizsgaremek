<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable;

    protected $table = 'users';

    public $timestamps = false;

    protected $fillable = [
        'username',
        'email',
        'password',
        'role',
        'created_at'
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    public function configurations()
    {
        return $this->hasMany(WatchConfiguration::class, 'user_id');
    }

    public function orders()
    {
        return $this->hasMany(Order::class, 'user_id');
    }

    public function auditLogs()
    {
        return $this->hasMany(AuditLog::class, 'user_id');
    }
}