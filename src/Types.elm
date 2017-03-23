module Types exposing (..)

import Dict exposing (Dict)
import Http
import Time exposing (Time)


type Msg
    = PrimaryPhoto String
    | Title String


type alias Joke =
    String


type alias Jokes =
    List Joke


type alias Url =
    String


type alias Model =
    { photos :
        { first : List Url
        , second : List Url
        , selectedPhoto : Maybe Url
        }
    , globalTime : Time.Time
    , title : String
    }
