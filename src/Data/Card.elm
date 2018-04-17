module Data.Card exposing (Card)

import Data.Card.Attribute exposing (Attribute)


type alias Card =
    { id : Int, name : String, attributes : List Attribute }
