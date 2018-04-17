module Card.Controller exposing (..)

import Data.Card exposing (Card)
import Data.Card.Attribute exposing (Attribute)
import Dict


maybeGetAttributeValue : Card -> String -> Maybe String
maybeGetAttributeValue card key =
    Dict.get key (Dict.fromList card.attributes)
