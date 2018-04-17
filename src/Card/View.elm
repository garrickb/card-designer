module Card.View exposing (..)

import Card.Controller exposing (maybeGetAttributeValue)
import CardTemplate.View exposing (drawTextWithReplacement)
import Data.Card exposing (Card)
import Data.Card.Attribute as CardAttribute
import Data.CardTemplate exposing (CardTemplate)
import Data.CardTemplate.Text as CardTemplateText
import Html exposing (Html, div, table, tbody, th, thead, tr)
import Html.Attributes
import Html.Events exposing (onInput)
import State
import Svg exposing (..)
import Svg.Attributes exposing (..)


drawAttributeEdit : Card -> CardAttribute.Attribute -> Html State.Msg
drawAttributeEdit card attribute =
    tr
        []
        [ Html.th [] [ Html.text (Tuple.first attribute) ]
        , Html.td [] [ Html.input [ Html.Attributes.value (Tuple.second attribute), onInput (State.EditCard card.id attribute) ] [] ]
        , Html.button [ Html.Events.onClick (State.DeleteCardAttribute card.id attribute) ] [ Html.text "Delete Attribute" ]
        ]


drawAttributesEdit : Card -> Html State.Msg
drawAttributesEdit card =
    div []
        [ table
            []
            (List.append
                (List.map
                    (drawAttributeEdit card)
                    card.attributes
                )
                (List.singleton
                    (Html.td [] [])
                )
            )
        ]


replaceAttributeWithValue : List CardAttribute.Attribute -> String -> String
replaceAttributeWithValue attributes attribute =
    let
        containsAttribute : CardAttribute.Attribute -> Maybe String
        containsAttribute a =
            if Tuple.first a == attribute then
                Just (Tuple.second a)
            else
                Nothing
    in
    Maybe.withDefault attribute
        (List.head (List.filterMap containsAttribute attributes))


drawCardSvg : CardTemplate -> Card -> List (Svg State.Msg)
drawCardSvg template card =
    Svg.rect
        [ width "286"
        , height "400"
        , fill "black"
        ]
        []
        :: List.map
            (drawTextWithReplacement
                (replaceAttributeWithValue card.attributes)
            )
            template.texts


drawCard : CardTemplate -> Card -> Html State.Msg
drawCard template card =
    Html.div
        [ Html.Attributes.style
            [ ( "flex-basis", "25%" )
            , ( "text-align", "center" )
            ]
        ]
        [ svg
            [ height "200", viewBox "0 0 286 400" ]
            (drawCardSvg template card)
        ]


drawCardAndEditor : CardTemplate -> Card -> Html State.Msg
drawCardAndEditor template card =
    div
        [ Html.Attributes.style
            [ ( "display", "flex" )
            , ( "padding", "10px" )
            ]
        ]
        [ drawCard template card
        , Html.div
            [ Html.Attributes.style
                [ ( "flex-basis", "75%" ) ]
            ]
            [ Html.p [] [ text card.name ]
            , drawAttributesEdit card
            , Html.button [ Html.Events.onClick (State.DeleteCard card.id) ] [ text "Delete Card" ]
            ]
        ]


drawCards : List Card -> CardTemplate -> Html State.Msg
drawCards cards cardTemplate =
    div []
        (List.map
            (drawCardAndEditor
                cardTemplate
            )
            cards
        )
