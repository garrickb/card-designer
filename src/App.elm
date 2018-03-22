module App exposing (main)

import Html
import State
import View


main : Program Never State.Model State.Msg
main =
    Html.beginnerProgram
        { model = State.defaultState
        , view = View.rootView
        , update = State.update
        }
