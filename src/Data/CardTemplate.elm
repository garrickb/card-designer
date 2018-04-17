module Data.CardTemplate exposing (..)

import Data.CardTemplate.Text exposing (Text)


type alias CardTemplate =
    { id : Int, texts : List Text }
