<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PostGamesRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return auth('api')->guest();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name' => 'required|string', // can support dupes (will unique by slug)
            'url'  => 'required|unique:games|url',
            'short_description' => 'required|max:140',
        ];
    }
}