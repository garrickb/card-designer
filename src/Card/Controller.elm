module Card.Controller exposing (..)

import Card.Model exposing (Attribute, Card)
import Dict


getValue : Card -> String -> Maybe String
getValue card key =
    Dict.get key (Dict.fromList card.attributes)
