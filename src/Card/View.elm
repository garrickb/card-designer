module Card.View exposing (..)

import Card.Controller exposing (getValue)
import Card.Model exposing (Attribute, Card)
import Html exposing (Html, div, table, tbody, th, thead, tr)
import Html.Attributes
import Html.Events exposing (onInput)
import State
import Svg exposing (..)
import Svg.Attributes exposing (..)


drawAttribute : Card -> Card.Model.Attribute -> Html State.Msg
drawAttribute card attribute =
    tr
        []
        [ Html.th [] [ Html.text (Tuple.first attribute) ]
        , Html.td [] [ Html.input [ Html.Attributes.value (Tuple.second attribute), onInput (State.EditCard card attribute) ] [] ]
        , Html.button [ Html.Events.onClick (State.DeleteAttribute card attribute) ] [ Html.text "Delete" ]
        ]


drawAttributes : Card -> Html State.Msg
drawAttributes card =
    div []
        [ table
            []
            (List.append
                (List.map
                    (drawAttribute card)
                    card.attributes
                )
                (List.singleton
                    (Html.td [ Html.Attributes.align "center" ]
                        [ Html.button [] [ Html.text "Add Attribute" ] ]
                    )
                )
            )
        ]


drawCard : Card -> Html State.Msg
drawCard card =
    div
        [ Html.Attributes.style
            [ ( "padding", "10px" ) ]
        ]
        [ svg
            [ height "200", viewBox "0 0 286 400" ]
            [ Svg.rect
                [ width "286"
                , height "400"
                , fill "black"
                ]
                []
            , Svg.text_
                [ x "143"
                , y "25"
                , fontSize "25"
                , fill "white"
                , textAnchor "middle"
                , Html.Attributes.style
                    []
                ]
                [ drawAttributes card ]
            ]
        ]


drawCardDetailed : Card -> Html State.Msg
drawCardDetailed card =
    div
        [ Html.Attributes.style
            [ ( "display", "flex" )
            , ( "padding", "10px" )
            ]
        ]
        [ Html.div
            [ Html.Attributes.style
                [ ( "flex-basis", "25%" )
                , ( "text-align", "center" )
                ]
            ]
            [ svg
                [ height "200", viewBox "0 0 286 400" ]
                [ Svg.rect
                    [ width "286"
                    , height "400"
                    , fill "black"
                    ]
                    []
                , Svg.text_
                    [ x "143"
                    , y "25"
                    , fontSize "25"
                    , fill "white"
                    , textAnchor "middle"
                    , Html.Attributes.style
                        []
                    ]
                    [ Html.text (Maybe.withDefault "-No Value-" (getValue card "text")) ]
                ]
            ]
        , Html.div
            [ Html.Attributes.style
                [ ( "flex-basis", "75%" ) ]
            ]
            [ Html.p [] [ text card.name ]
            , drawAttributes card
            ]
        ]


drawCards : List Card -> Html State.Msg
drawCards cards =
    div []
        (List.map
            drawCardDetailed
            cards
        )
