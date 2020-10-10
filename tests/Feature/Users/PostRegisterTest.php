<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class PostRegisterTest extends TestCase
{
    /**
     * A user can register with correct input
     *
     * @return void
     */
    public function testPostRegisterWithCorrectInput()
    {
        $random_uuid = uniqid();
        $response = $this->withHeaders([
            'Accept' => 'application/json',
        ])->post('/register', [
            'name' => 'User_' . $random_uuid,
            'email' => 'foo_' . $random_uuid . '@bar.baz',
            'password' => 'foobarbaz'
        ]);
        $response->assertStatus(200);
    }

    /**
     * A user cannot register with incorrect input
     *
     * @return void
     */
    public function testPostRegisterWithIncorrectInput()
    {
        $random_uuid = uniqid();
        $response = $this->withHeaders([
            'Accept' => 'application/json',
        ])->post('/register', [
            'name' => 'User_' . $random_uuid,
            'email' => 'foo_' . $random_uuid . '@bar.baz',
            'password' => 'foobar'
        ]);

        $response->assertStatus(422);
    }

    /**
     * A user cannot register with empty input
     *
     * @return void
     */
    public function testPostRegisterWithEmptyInput()
    {
        $response = $this->withHeaders([
            'Accept' => 'application/json',
        ])->post('/register');

        $response->assertStatus(422);
    }
}
