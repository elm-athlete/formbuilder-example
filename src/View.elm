module View exposing (..)

import Types exposing (..)
import Html exposing (Html, div)
import Html.Attributes
import Html.Events
import FormBuilder.FieldBuilder as FieldBuilder
import FormBuilder.FieldBuilder.Attributes as Attributes exposing (..)
import FormBuilder.FieldBuilder.Events as Events exposing (..)
import FormBuilder.Photo as Photo
import FormBuilder.Photo.Attributes as Photo
import FormBuilder.Autocomplete.Attributes as AutocompleteAttributes
import FormBuilder.Autocomplete as AutocompleteView
import FormBuilder
import Maybe exposing (withDefault)
import Dict
import Date


view : Model -> Html Msg
view model =
    let
        formName =
            "Chuck Norris"

        defaultAttrs attributes =
            objectName formName :: attributes

        defaultInput attributes =
            FieldBuilder.default <| defaultAttrs <| attributes

        photo attributes =
            Photo.default <| defaultAttrs <| attributes
    in
        div []
            [ div []
                [ Html.form [ Html.Attributes.action "javascript:void(0)" ]
                    [ Html.text model.title
                    , AutocompleteView.default
                        [ placeholder "Commencez à taper le nom de la sortie..."
                        , value model.autocomplete.searchQuery
                        , Events.onInput LaunchAutocomplete
                        , AutocompleteAttributes.selection
                            (Just
                                [ ( "Jokes"
                                  , model.autocomplete.elements
                                  )
                                ]
                            )
                            (\joke -> joke)
                            ReplaceJoke
                            model.autocomplete.searchQuery
                            True
                        , AutocompleteAttributes.selectedElement model.autocomplete
                        , noBottomPadding
                        ]
                    ]
                , photo
                    [ fieldName "remote_image_url"
                    , label "Choose an image"
                    , Photo.selection
                        (Just
                            [ ( "First", model.photos.first )
                            , ( "Second", model.photos.second )
                            ]
                        )
                        model.photos.selectedPhoto
                        PrimaryPhoto
                    , value (List.head model.photos.first |> withDefault "")
                    , mandatory
                    ]
                , defaultInput
                    [ fieldName "title"
                    , label "Titre"
                    , placeholder "Ex : Le meilleur burger de Paris"
                    , onInput Title
                    , value model.title
                    , mandatory
                    ]
                ]
            , Html.text model.joke
            ]
