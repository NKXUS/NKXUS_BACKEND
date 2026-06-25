
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class SupportTicketController extends Controller
{
    /**
     * Store a Contact Us submission.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => [
                'required',
                'string',
                'max:150',
            ],

            'email' => [
                'required',
                'string',
                'email',
                'max:255',
            ],

            'message' => [
                'required',
                'string',
                'max:5000',
            ],
        ]);

        if (!Schema::hasTable('support_tickets')) {
            return response()->json([
                'success' => false,
                'message' => 'The support_tickets table does not exist.',
            ], 500);
        }

        $columns = Schema::getColumnListing(
            'support_tickets'
        );

        $payload = [];

        /*
        |--------------------------------------------------------------------------
        | Name
        |--------------------------------------------------------------------------
        */

        if (in_array('name', $columns, true)) {
            $payload['name'] = trim(
                $validated['name']
            );
        } elseif (
            in_array('full_name', $columns, true)
        ) {
            $payload['full_name'] = trim(
                $validated['name']
            );
        } elseif (
            in_array('customer_name', $columns, true)
        ) {
            $payload['customer_name'] = trim(
                $validated['name']
            );
        }

        /*
        |--------------------------------------------------------------------------
        | Email
        |--------------------------------------------------------------------------
        */

        if (in_array('email', $columns, true)) {
            $payload['email'] = strtolower(
                trim($validated['email'])
            );
        } elseif (
            in_array('customer_email', $columns, true)
        ) {
            $payload['customer_email'] = strtolower(
                trim($validated['email'])
            );
        }

        /*
        |--------------------------------------------------------------------------
        | Message
        |--------------------------------------------------------------------------
        */

        if (in_array('message', $columns, true)) {
            $payload['message'] = trim(
                $validated['message']
            );
        } elseif (
            in_array('description', $columns, true)
        ) {
            $payload['description'] = trim(
                $validated['message']
            );
        } elseif (
            in_array('details', $columns, true)
        ) {
            $payload['details'] = trim(
                $validated['message']
            );
        }

        /*
        |--------------------------------------------------------------------------
        | Optional fields
        |--------------------------------------------------------------------------
        */

        if (in_array('status', $columns, true)) {
            $payload['status'] = 'open';
        }

        if (in_array('priority', $columns, true)) {
            $payload['priority'] = 'normal';
        }

        if (in_array('user_id', $columns, true)) {
            $payload['user_id'] = null;
        }

        if (in_array('created_at', $columns, true)) {
            $payload['created_at'] = now();
        }

        if (in_array('updated_at', $columns, true)) {
            $payload['updated_at'] = now();
        }

        if (
            !array_key_exists('name', $payload) &&
            !array_key_exists('full_name', $payload) &&
            !array_key_exists('customer_name', $payload)
        ) {
            return response()->json([
                'success' => false,
                'message' =>
                    'No compatible name column exists in support_tickets.',
                'columns' => $columns,
            ], 500);
        }

        if (
            !array_key_exists('email', $payload) &&
            !array_key_exists('customer_email', $payload)
        ) {
            return response()->json([
                'success' => false,
                'message' =>
                    'No compatible email column exists in support_tickets.',
                'columns' => $columns,
            ], 500);
        }

        if (
            !array_key_exists('message', $payload) &&
            !array_key_exists('description', $payload) &&
            !array_key_exists('details', $payload)
        ) {
            return response()->json([
                'success' => false,
                'message' =>
                    'No compatible message column exists in support_tickets.',
                'columns' => $columns,
            ], 500);
        }

        DB::table('support_tickets')->insert(
            $payload
        );

        return response()->json([
            'success' => true,
            'message' =>
                'Your message has been submitted successfully.',
        ], 201);
    }
}

