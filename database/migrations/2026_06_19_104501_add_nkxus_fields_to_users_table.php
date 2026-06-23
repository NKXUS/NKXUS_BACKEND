
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Add missing NKXUS fields to the imported smmusers table.
     */
    public function up(): void
    {
        if (!Schema::hasTable('smmusers')) {
            return;
        }

        Schema::table('smmusers', function (Blueprint $table) {
            if (!Schema::hasColumn('smmusers', 'name')) {
                $table->string('name')->nullable();
            }

            if (!Schema::hasColumn('smmusers', 'username')) {
                $table->string('username', 100)
                    ->nullable()
                    ->unique();
            }

            if (!Schema::hasColumn('smmusers', 'status')) {
                $table->string('status', 20)
                    ->default('active');
            }

            if (!Schema::hasColumn('smmusers', 'remember_token')) {
                $table->rememberToken();
            }
        });
    }

    /**
     * Imported database columns are preserved during rollback.
     */
    public function down(): void
    {
        // Intentionally left empty to protect imported user data.
    }
};

