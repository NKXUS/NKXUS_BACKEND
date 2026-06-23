<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SupportTicketController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => [
                'required',
                'string',
                'max:255',
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

        $ticketId = DB::table('support_tickets')->insertGetId([
            'user_id' => null,
            'order_id' => null,
            'subject' => 'Contact Us',
            'message' => trim($validated['message']),
            'status' => 'open',
            'email' => strtolower(trim($validated['email'])),
            'full_name' => trim($validated['name']),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Your message has been submitted successfully.',
            'ticket_id' => $ticketId,
        ], 201);
    }
}