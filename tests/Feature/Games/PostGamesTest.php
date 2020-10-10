<?php

namespace Tests\Feature;

use App\Models\Game;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class PostGamesTest extends TestCase
{
    use WithFaker;
    /**
     * A game can be submitted with correct input
     *
     * @return void
     */
    public function testPostGamesWithCorrectInput()
    {
        $response = $this->withHeaders([
            'Accept' => 'application/json',
        ])->post('/games', [
            'name' => $this->faker->name,
            'url' => $this->faker->unique()->url,
            'short_description' => $this->faker->text($maxNbChars = 140),
            'long_description' => $this->faker->text(),
            'image_path' => $this->faker->imageUrl($width = 125, $height = 125),
            'approved' => $this->faker->boolean($chanceOfGettingTrue = 50),
            'verified' => $this->faker->boolean($chanceOfGettingTrue = 50),
            'promoted' => $this->faker->boolean($chanceOfGettingTrue = 50),
        ]);

        $response->assertStatus(200);
    }

    /**
     * A game cannot be submitted with incorrect input
     *
     * @return void
     */
    public function testPostGamesWithIncorrectInput()
    {
        $input_game = Game::factory()->create();

        $response = $this->withHeaders([
            'Accept' => 'application/json',
        ])->post('/games', [
            'name' => 'some ! bad @ characters # to $ test %',
            'url' => 'not_a_url',
            'short_description' => $input_game->long_description,
            'long_description' => '',
            'image_path' => $input_game->image_path,
            'approved' => 'string',
            'verified' => $input_game->verified,
            'promoted' => $input_game->promoted,
        ]);

        $response->assertStatus(422);
    }

    /**
     * A game cannot be submitted with empty input
     *
     * @return void
     */
    public function testPostGamesWithEmptyInput()
    {
        $response = $this->withHeaders([
            'Accept' => 'application/json',
        ])->post('/games');

        $response->assertStatus(422);
    }
}
