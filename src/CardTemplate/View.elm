module CardTemplate.View exposing (..)

import Basics
import CardTemplate.Controller exposing (replaceText)
import Data.CardTemplate exposing (CardTemplate)
import Data.CardTemplate.Text exposing (Text)
import Html exposing (Html, div, table, tbody, th, thead, tr)
import Html.Attributes
import Html.Events exposing (onInput)
import State exposing (Msg)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Util.ColorHelper exposing (colorToHex)


drawTextWithReplacement : (String -> String) -> Text -> Svg Msg
drawTextWithReplacement replacementMethod text =
    drawText (replaceText text replacementMethod)


drawText : Text -> Svg Msg
drawText text =
    Svg.text_
        [ x (toString text.x)
        , y (toString text.y)
        , fontSize "25"
        , fill (colorToHex text.color)
        , textAnchor "middle"
        , Html.Attributes.style
            []
        ]
        [ Html.text text.value ]


drawCardTemplate : CardTemplate -> Html Msg
drawCardTemplate template =
    let
        text =
            List.map drawText template.texts
    in
    svg
        [ height "200", viewBox "-100 -50 500 500" ]
        (List.append
            [ Svg.rect
                [ width "286"
                , height "400"
                , fill "black"
                ]
                []
            ]
            text
        )
