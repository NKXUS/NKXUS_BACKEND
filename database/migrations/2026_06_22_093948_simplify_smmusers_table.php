
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Keep only id, email and password.
     */
    public function up(): void
    {
        if (!Schema::hasTable('smmusers')) {
            return;
        }

        $columnsToRemove = [
            'username',
            'phone_number',
            'balance',
            'api_key',
            'api_token',
            'google_id',
            'google_avatar',
            'profile_image',
            'role',
            'referrer_id',
            'language',
            'timezone',
            'currency',
            'two_fa_enabled',
            'telegram_id',
            'created_at',
            'updated_at',
        ];

        /*
         * Remove foreign keys connected to columns
         * that are going to be deleted.
         */
        $foreignKeys = DB::select(
            '
                SELECT CONSTRAINT_NAME, COLUMN_NAME
                FROM information_schema.KEY_COLUMN_USAGE
                WHERE TABLE_SCHEMA = DATABASE()
                  AND TABLE_NAME = ?
                  AND REFERENCED_TABLE_NAME IS NOT NULL
            ',
            ['smmusers']
        );

        foreach ($foreignKeys as $foreignKey) {
            if (
                in_array(
                    $foreignKey->COLUMN_NAME,
                    $columnsToRemove,
                    true
                )
            ) {
                DB::statement(
                    sprintf(
                        'ALTER TABLE `smmusers` DROP FOREIGN KEY `%s`',
                        str_replace(
                            '`',
                            '``',
                            $foreignKey->CONSTRAINT_NAME
                        )
                    )
                );
            }
        }

        $existingColumns = array_filter(
            $columnsToRemove,
            fn (string $column): bool =>
                Schema::hasColumn('smmusers', $column)
        );

        if (!empty($existingColumns)) {
            Schema::table(
                'smmusers',
                function (Blueprint $table) use (
                    $existingColumns
                ): void {
                    $table->dropColumn($existingColumns);
                }
            );
        }
    }

    /**
     * Removed imported data cannot be restored automatically.
     */
    public function down(): void
    {
        // Intentionally empty.
    }
};

