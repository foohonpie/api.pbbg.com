<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class GetGamesTest extends TestCase
{
    /**
     * An authenticated game can access the game page
     *
     * @return void
     */
    public function testGetGames()
    {
        $response = $this->withHeaders(['Accept' => 'application/json'])->get('/games');
        $response->assertStatus(200);
    }
}
