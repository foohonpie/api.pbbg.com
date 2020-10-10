<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class PostLoginTest extends TestCase
{
    /**
     * A user can log in with valid credentials
     *
     * @return void
     */
    public function testPostLogInWithValidCredentials()
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

        $response = $this->post('/login', [
            'email' => 'foo_' . $random_uuid . '@bar.baz',
            'password' => 'foobarbaz',
        ]);
        $response->assertStatus(200);
    }

    /**
     * A user cannot log in with invalid credentials
     *
     * @return void
     */
    public function testPostLogInWithInvalidCredentials()
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

        $response = $this->post('/login', [
            'email' => 'foo_' . $random_uuid . '@bar.baz',
            'password' => 'incorrectpassword'
        ]);
        $response->assertStatus(401);
    }

    /**
     * A user cannot log in with empty credentials
     *
     * @return void
     */
    public function testPostLogInWithEmptyCredentials()
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

        $response = $this->post('/login');

        $response->assertStatus(422);
    }
}
