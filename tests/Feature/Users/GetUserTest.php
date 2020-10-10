<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class GetUserTest extends TestCase
{
    /**
     * An authenticated user can access the user page
     *
     * @return void
     */
    public function testGetUser()
    {
        $random_uuid = uniqid();
        $response = $this->withHeaders([
            'Accept' => 'application/json',
        ])->post('/register', [
            'name' => 'User_' . $random_uuid,
            'email' => 'foo_' . $random_uuid . '@bar.baz',
            'password' => 'foobarbaz'
        ]);

        $response = $this->get('/users/1');
        $response->assertStatus(200);
    }
}
