<?php

namespace App\Http\Controllers;

use App\Http\Requests\PostGamesRequest;
use App\Models\Game;
use App\Http\Resources\Game as GameResource;
use Illuminate\Http\Request;

class GameController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return GameResource::collection(Game::paginate());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(PostGamesRequest $request)
    {
        $game = Game::create(
            [
                'name' => $request->name,
                'url' => $request->url,
                'short_description' => $request->short_description
            ]
        );

        return new GameResource(Game::find($game->id));
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Game $game
     * @return \Illuminate\Http\Response
     */
    public function show($game_id)
    {
        return new GameResource(Game::find($game_id));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  \App\Models\Game         $game
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Game $game)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Game $game
     * @return \Illuminate\Http\Response
     */
    public function destroy(Game $game)
    {
        //
    }
}
