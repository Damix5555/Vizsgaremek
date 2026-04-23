<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConfigurationPart extends Model
{
    protected $table = 'configuration_parts';

    public $timestamps = false;

    protected $fillable = [
        'configuration_id',
        'product_id'
    ];

    public function configuration()
    {
        return $this->belongsTo(WatchConfiguration::class, 'configuration_id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
}