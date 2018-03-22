module State exposing (..)

import Card.Model exposing (Attribute, Card)
import List exposing (singleton)


type Msg
    = AddCard
    | EditCard Card Attribute String
    | DeleteAttribute Card Attribute


type alias Model =
    { cards : List Card, nextId : Int }


defaultState : Model
defaultState =
    { nextId = 1, cards = singleton (Card 0 "Starting Card Name" [ ( "text", "Starting Card" ) ]) }


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCard ->
            { model | nextId = model.nextId + 1, cards = Card model.nextId "New Card Name" [ ( "text", "New Card" ) ] :: model.cards }

        EditCard card attribute newText ->
            let
                updateAttribute : Attribute -> Attribute
                updateAttribute a =
                    if Tuple.first attribute == Tuple.first a then
                        ( Tuple.first attribute, newText )
                    else
                        a

                updateCard : Card -> Card
                updateCard c =
                    if card == c then
                        { c | attributes = List.map updateAttribute c.attributes }
                    else
                        c
            in
            { model | cards = List.map updateCard model.cards }

        DeleteAttribute card attribute ->
            let
                compareAttributes : Attribute -> Attribute -> Bool
                compareAttributes c1 c2 =
                    c1 /= c2

                removeAttributeFromCard : Attribute -> Card -> Card
                removeAttributeFromCard a c =
                    if card == c then
                        { c | attributes = List.filter (compareAttributes a) c.attributes }
                    else
                        c
            in
            { model | cards = List.map (removeAttributeFromCard attribute) model.cards }
