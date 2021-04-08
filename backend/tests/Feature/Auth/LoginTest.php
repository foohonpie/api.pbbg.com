<?php

namespace Tests\Feature\Auth;

use App\Models\User;
use Database\Factories\UserFactory;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\BaseTest;

class LoginTest extends BaseTest
{
    use RefreshDatabase;

    protected User $user;

    public function setUp(): void
    {
        parent::setUp();
        $this->user = UserFactory::new()->testUser()->create();
    }

    /** @test */
    public function successfully_login()
    {
        $response = $this->postJson('/api/login', [
            'email' => 'testuser@example.com',
            'password' => 'pAsSwOrD',
        ]);

        $response->assertStatus(200);
        $this->assertAuthenticated();
    }

    /** @test */
    public function incorrect_credentials()
    {
        $response = $this->postJson('/api/login', [
            'email' => 'testuser@example.com',
            'password' => 'wrong password',
        ]);

        $response->assertStatus(422);
        $this->assertGuest();
    }

    /** @test */
    public function successfully_logout()
    {
        // First we log in
        $this->postJson('/api/login', [
            'email' => 'testuser@example.com',
            'password' => 'pAsSwOrD',
        ]);
        $this->assertAuthenticated();

        // Now we log out
        $response = $this->postJson('/api/logout');

        $response->assertStatus(204);
        $this->assertGuest();
    }
}
