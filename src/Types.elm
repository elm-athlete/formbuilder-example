module Types exposing (..)

import Dict exposing (Dict)
import Http
import Time exposing (Time)


type Msg
    = Jokes (Result Http.Error Jokes)
    | LaunchAutocomplete String
    | ReplaceJoke Joke
    | PrimaryPhoto String
    | Title String


type alias Joke =
    String


type alias Jokes =
    List Joke


type alias Url =
    String


type alias Model =
    { autocomplete :
        { sources : List (String -> Cmd Msg)
        , selectedElement : Maybe Int
        , elements : Jokes
        , searchQuery : String
        , fetchedElements : Dict String Jokes
        }
    , joke : String
    , photos :
        { first : List Url
        , second : List Url
        , selectedPhoto : Maybe Url
        }
    , globalTime : Time.Time
    , title : String
    }
