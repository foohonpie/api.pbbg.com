<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class GetUsersTest extends TestCase
{
    /**
     * Get list of users
     *
     * @return void
     */
    public function testGetUsers()
    {
        $response = $this->withHeaders(['Accept' => 'application/json'])->get('/users');
        $response->assertStatus(200);
    }
}
