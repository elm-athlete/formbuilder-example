module HttpRequests exposing (..)

import Http exposing (..)
import Types exposing (..)
import Json.Decode as Json exposing (..)


decodeJokes : Decoder (List String)
decodeJokes =
    Json.at [ "value" ] <| Json.list decodeJoke


decodeJoke : Decoder String
decodeJoke =
    Json.field "joke" Json.string
