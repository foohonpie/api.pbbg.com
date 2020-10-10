<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class GetAuthenticatedUserTest extends TestCase
{
    /**
     * An authenticated user can access their user data
     *
     * @return void
     */
    public function testAnAuthenticatedUserCanAccessTheUserPage()
    {
        $random_uuid = uniqid();
        $response = $this->withHeaders([
            'Accept' => 'application/json',
        ])->post('/register', [
            'name' => 'User_' . $random_uuid,
            'email' => 'foo_' . $random_uuid . '@bar.baz',
            'password' => 'foobarbaz'
        ]);
        $response_json = json_decode($response->content());
        $token = $response_json->token;
        $this->assertNotEquals('', $token); # improve this to check that token is valid JWT

        $response = $this->withHeaders([
            'Authorization' => "Bearer $token"
        ])->get('/user');
        $response->assertStatus(200);
    }

    /**
     * An unauthenticated user cannot access user data
     *
     * @return void
     */
    public function testAnUnauthetnicatedUserCannotAccessTheUserPage()
    {
        $random_uuid = uniqid();
        $response = $this->withHeaders([
            'Accept' => 'application/json',
        ])->post('/register', [
            'name' => 'User_' . $random_uuid,
            'email' => 'foo_' . $random_uuid . '@bar.baz',
            'password' => 'foobarbaz'
        ]);
        $response_json = json_decode($response->content());
        $token = $response_json->token;
        $this->assertNotEquals('', $token); # improve this to check that token is valid JWT

        $response = $this->get('/user');
        $response->assertStatus(401);

        $response = $this->withHeaders([
            'Authorization' => "Bearer InvalidToken"
        ])->get('/user');
        $response->assertStatus(401);
    }

}
