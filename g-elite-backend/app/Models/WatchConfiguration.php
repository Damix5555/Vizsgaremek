<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WatchConfiguration extends Model
{
    protected $table = 'watch_configurations';

    public $timestamps = false;

    protected $fillable = [
        'user_id',
        'name',
        'total_price',
        'created_at'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function parts()
    {
        return $this->hasMany(ConfigurationPart::class, 'configuration_id');
    }
}