module Card.Model exposing (..)


type alias Attribute =
    ( String, String )


type alias Card =
    { id : Int, name : String, attributes : List Attribute }
