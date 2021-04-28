<?php

namespace Tests\Feature\Auth;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\BaseTest;

class RegistrationTest extends BaseTest
{
    use RefreshDatabase;

    public function setUp(): void
    {
        parent::setUp();
    }

    /** @test */
    public function successfully_register()
    {
        $response = $this->postJson('/api/auth/register', [
            'name' => 'Test User',
            'email' => 'testuser@example.com',
            'password' => 'pAsSwOrD',
            'password_confirmation' => 'pAsSwOrD',
        ]);

        $response->assertStatus(201);
    }

    /** @test */
    public function cannot_register_without_all_fields()
    {
        $response = $this->postJson('/api/auth/register', [
            'email' => 'testuser@example.com',
            'password' => 'pAsSwOrD',
            'password_confirmation' => 'pAsSwOrD',
        ]);

        $response->assertStatus(422);
    }

    /** @test */
    public function cannot_register_with_mismatched_passwords()
    {
        $response = $this->postJson('/api/auth/register', [
            'name' => 'Test User',
            'email' => 'testuser@example.com',
            'password' => 'pAsSwOrD',
            'password_confirmation' => 'what is this?',
        ]);

        $response->assertStatus(422);
    }
}
