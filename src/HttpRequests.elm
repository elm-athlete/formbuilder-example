module HttpRequests exposing (..)

import Http exposing (..)
import Types exposing (..)
import Json.Decode as Json exposing (..)


askChuck : String -> Cmd Msg
askChuck q =
    Http.send
        Jokes
        (Http.get ("http://api.icndb.com/jokes/random/10?firstName=" ++ q)
            decodeJokes
        )


decodeJokes : Decoder (List String)
decodeJokes =
    Json.at [ "value" ] <| Json.list decodeJoke


decodeJoke : Decoder String
decodeJoke =
    Json.field "joke" Json.string
