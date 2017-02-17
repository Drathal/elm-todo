module AddTodo exposing (..)

import Html exposing (Html, div, input, button, text)
import Html.Events exposing (onSubmit, onInput, onClick)
import Html.Attributes exposing (type_)


view : (String -> msg) -> Html msg
view msg =
    div []
        [ input [ type_ "text" ] []
        , button [ onClick (msg "HELLO") ] [ text "Add" ]
        ]
