module View exposing (..)

import Card.View exposing (drawCards)
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (style)
import Html.Events
import State exposing (Model, Msg)


rootView : Model -> Html Msg
rootView model =
    div
        [ style
            [ ( "padding-left", "20px" )
            , ( "padding-right", "20px" )
            ]
        ]
        [ h1 [] [ text "Card Designer" ]
        , drawCards model.cards
        , div []
            [ Html.button
                [ Html.Events.onClick State.AddCard ]
                [ Html.text "Create New Card" ]
            ]
        ]
