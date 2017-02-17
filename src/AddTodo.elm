module AddTodo exposing (..)

import Html exposing (Html, div, input, button, text)
import Html.Events exposing (onSubmit, onInput, onClick)
import Html.Attributes exposing (type_, value)


view : msg -> (String -> msg) -> String -> Html msg
view addmsg inputmsg task =
    div []
        [ input [ type_ "text", value task, onInput inputmsg ] []
        , button [ onClick addmsg ] [ text "Add" ]
        ]
