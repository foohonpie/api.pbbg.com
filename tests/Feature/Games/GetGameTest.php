<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class GetGameTest extends TestCase
{
    /**
     * An authenticated game can access the game page
     *
     * @return void
     */
    public function testGetGame()
    {
        $response = $this->get('/games/1');
        $response->assertStatus(200);
    }
}
