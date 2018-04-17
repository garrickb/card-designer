module State exposing (..)

import Color exposing (rgb)
import Data.Card exposing (Card)
import Data.Card.Attribute exposing (Attribute)
import Data.CardTemplate exposing (CardTemplate)
import Data.CardTemplate.Text exposing (Text)
import List exposing (singleton)


type Msg
    = AddCard
    | EditCard Int Attribute String
    | DeleteCard Int
    | DeleteCardAttribute Int Attribute


type alias Model =
    { cards : List Card, template : CardTemplate, nextId : Int }


defaultState : Model
defaultState =
    { nextId = 2
    , cards = singleton (Card 0 "Starting Card Name" [ ( "text", "Starting Card" ) ])
    , template =
        CardTemplate 2 (singleton (Text 143 25 "text" (rgb 255 255 255)))
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCard ->
            { model | nextId = model.nextId + 1, cards = Card model.nextId "New Card Name" [ ( "text", "New Card" ) ] :: model.cards }

        EditCard cardId attribute newText ->
            let
                updateAttribute : Attribute -> Attribute
                updateAttribute a =
                    if Tuple.first attribute == Tuple.first a then
                        ( Tuple.first attribute, newText )
                    else
                        a

                updateCard : Card -> Card
                updateCard c =
                    if cardId == c.id then
                        { c | attributes = List.map updateAttribute c.attributes }
                    else
                        c
            in
            { model | cards = List.map updateCard model.cards }

        DeleteCard cardId ->
            { model | cards = List.filter (\c -> c.id /= cardId) model.cards }

        DeleteCardAttribute cardId attribute ->
            let
                compareAttributes : Attribute -> Attribute -> Bool
                compareAttributes c1 c2 =
                    c1 /= c2

                removeAttributeFromCard : Attribute -> Card -> Card
                removeAttributeFromCard a c =
                    if cardId == c.id then
                        { c | attributes = List.filter (compareAttributes a) c.attributes }
                    else
                        c
            in
            { model | cards = List.map (removeAttributeFromCard attribute) model.cards }
