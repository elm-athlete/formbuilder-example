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
    ( { autocomplete =
            { sources = [ HttpRequests.askChuck ]
            , selectedElement = Nothing
            , elements = []
            , searchQuery = ""
            , fetchedElements = Dict.empty
            }
      , joke = ""
      , photos =
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
update action ({ autocomplete, photos } as model) =
    case action of
        LaunchAutocomplete q ->
            let
                autocomplete_ =
                    { autocomplete | searchQuery = q }
            in
                ( { model | autocomplete = autocomplete_ }
                , performAutocompleteSearch model.autocomplete
                )

        Jokes result ->
            case result of
                Ok joke ->
                    Debug.log "meh" ( updateAutocompleteElements model joke, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        ReplaceJoke string ->
            let
                autocomplete_ =
                    { autocomplete | elements = [] }
            in
                Debug.log "model"
                    ( { model
                        | joke = string
                        , autocomplete = autocomplete_
                      }
                    , Cmd.none
                    )

        PrimaryPhoto url ->
            let
                photos_ =
                    { photos | selectedPhoto = Just url }
            in
                ( { model | photos = photos_ }, Cmd.none )

        Title title ->
            ( { model | title = title }, Cmd.none )


performAutocompleteSearch : { a | searchQuery : String, fetchedElements : Dict String v, sources : List (String -> Cmd Msg) } -> Cmd Msg
performAutocompleteSearch { searchQuery, fetchedElements, sources } =
    if (String.length searchQuery) >= 5 && not (Dict.member searchQuery fetchedElements) then
        Cmd.batch <|
            List.map
                (\fun -> fun searchQuery)
                sources
    else
        Cmd.none


updateAutocompleteElements : Model -> Jokes -> Model
updateAutocompleteElements ({ autocomplete } as model) jokes =
    let
        updatedAutocomplete =
            { autocomplete
                | fetchedElements =
                    autocomplete.fetchedElements
                        |> Dict.insert autocomplete.searchQuery jokes
            }

        updatedAutocomplete_ =
            { updatedAutocomplete
                | elements =
                    (Dict.get updatedAutocomplete.searchQuery updatedAutocomplete.fetchedElements |> Maybe.withDefault [])
            }
    in
        { model | autocomplete = updatedAutocomplete_ }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
