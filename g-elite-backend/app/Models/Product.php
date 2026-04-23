<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $table = 'products';

    public $timestamps = false;

    protected $fillable = [
        'name',
        'type',
        'color',
        'material',
        'price',
        'image_url',
        'stock',
        'is_active'
    ];

    public function configurationParts()
    {
        return $this->hasMany(ConfigurationPart::class, 'product_id');
    }
}