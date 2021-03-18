<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;

class UserFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = User::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->name,
            'email' => $this->faker->safeEmail,
            'password' => Hash::make($this->faker->word),
        ];
    }

    public function testUser(): Factory
    {
        return $this->state(function () {
            return [
                'name' => 'Test User',
                'email' => 'testuser@example.com',
                'password' => Hash::make('pAsSwOrD'),
            ];
        });
    }
}
