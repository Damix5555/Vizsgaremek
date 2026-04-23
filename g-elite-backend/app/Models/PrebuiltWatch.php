<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PrebuiltWatch extends Model
{
    protected $table = 'prebuilt_watches';

    public $timestamps = false;

    protected $fillable = [
        'name',
        'description',
        'price',
        'image_url',
        'stock',
        'is_active',
        'created_at'
    ];

    public function orderItems()
    {
        return $this->hasMany(OrderItem::class, 'prebuilt_watch_id');
    }
}