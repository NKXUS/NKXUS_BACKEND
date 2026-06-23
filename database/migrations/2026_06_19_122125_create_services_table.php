<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('services', function (Blueprint $table) {
            $table->id();

            $table->foreignId('service_category_id')
                ->constrained('service_categories')
                ->cascadeOnUpdate()
                ->restrictOnDelete();

            $table->string('name', 150);
            $table->string('slug', 170)->unique();
            $table->text('description')->nullable();

            $table->unsignedInteger('minimum_quantity')->default(10);
            $table->unsignedInteger('maximum_quantity')->default(10000);

            $table->decimal('rate_per_1000', 12, 2);
            $table->decimal('old_price', 12, 2)->nullable();

            $table->string('delivery_time', 100)->nullable();
            $table->string('quality', 100)->nullable();

            $table->string('provider_service_id', 100)->nullable();

            $table->boolean('status')->default(true);

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('services');
    }
};