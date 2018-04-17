module View exposing (..)

import Card.View exposing (drawCards)
import CardTemplate.View exposing (drawCardTemplate)
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
        , drawCardTemplate model.template
        , drawCards model.cards model.template
        , div []
            [ Html.button
                [ Html.Events.onClick State.AddCard ]
                [ Html.text "Create New Card" ]
            ]
        ]
