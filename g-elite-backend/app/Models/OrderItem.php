<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderItem extends Model
{
    protected $table = 'order_items';

    public $timestamps = false;

    protected $fillable = [
        'order_id',
        'configuration_id',
        'prebuilt_watch_id',
        'quantity',
        'price'
    ];

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }

    public function configuration()
    {
        return $this->belongsTo(WatchConfiguration::class, 'configuration_id');
    }

    public function prebuiltWatch()
    {
        return $this->belongsTo(PrebuiltWatch::class, 'prebuilt_watch_id');
    }
}