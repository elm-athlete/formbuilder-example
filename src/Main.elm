module Main exposing (..)

import Html
import Types exposing (..)
import HttpRequests
import Dict exposing (Dict)
import View exposing (..)
import Maybe


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { photos =
            { first = [ "http://www.demotivateur.fr/images-buzz/4154/chuck-norris.jpg", "http://www.premiere.fr/sites/default/files/styles/premiere_film_fiche/public/thumbnails/image/abaca_83730_09.jpg" ]
            , second = [ "http://img.gal.pmdstatic.net/fit/http.3A.2F.2Fwww.2Egala.2Efr.2Fvar.2Fgal.2Fstorage.2Fimages.2Fstars_et_gotha.2Fchuck_norris.2F1920736-95-fre-FR.2Fchuck_norris.2Ejpg/460x259/quality/80/chuck-norris.jpg" ]
            , selectedPhoto = Nothing
            }
      , globalTime = 0
      , title = "Chuck Norris Jokes"
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update action ({ photos } as model) =
    case action of
        PrimaryPhoto url ->
            let
                photos_ =
                    { photos | selectedPhoto = Just url }
            in
                ( { model | photos = photos_ }, Cmd.none )

        Title title ->
            ( { model | title = title }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
