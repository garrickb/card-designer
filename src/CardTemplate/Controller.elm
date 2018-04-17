module CardTemplate.Controller exposing (..)

import Data.CardTemplate exposing (..)
import Data.CardTemplate.Text exposing (..)


replaceText : Text -> (String -> String) -> Text
replaceText text replaceMethod =
    { text | value = replaceMethod text.value }
