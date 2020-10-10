<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class GetUsersTest extends TestCase
{
    /**
     * An authenticated user can access the user page
     *
     * @return void
     */
    public function testGetUsers()
    {
        $response = $this->withHeaders(['Accept' => 'application/json'])->get('/users');
        $response->assertStatus(200);
    }
}
