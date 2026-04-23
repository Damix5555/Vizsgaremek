<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('audit_logs', function (Blueprint $table) {
            $table->id();

            // A users.id nálad int(11), ezért itt is integer kell
            $table->integer('user_id')->nullable();

            $table->string('action', 50);
            $table->string('entity_type', 100);
            $table->unsignedBigInteger('entity_id')->nullable();

            $table->longText('old_values')->nullable();
            $table->longText('new_values')->nullable();

            $table->dateTime('created_at')->useCurrent();

            $table->foreign('user_id')
                ->references('id')
                ->on('users')
                ->nullOnDelete();

            $table->index(['entity_type', 'entity_id']);
            $table->index('action');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('audit_logs');
    }
};