<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class GetUserTest extends TestCase
{
    /**
     * Get user by id
     *
     * @return void
     */
    public function testGetUser()
    {
        $response = $this->get('/users/1');
        $response->assertStatus(200);
    }
}
