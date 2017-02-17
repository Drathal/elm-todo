module AddTodo exposing (..)

import Html exposing (Html, Attribute, div, input, button, text, header, h1)
import Html.Events exposing (on, onSubmit, onInput, onClick, keyCode)
import Html.Attributes exposing (type_, value, class, autofocus, placeholder, name)
import Json.Decode as Json


onEnter : msg -> Attribute msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg
            else
                Json.fail "not ENTER"
    in
        on "keydown" (Json.andThen isEnter keyCode)

view : msg -> (String -> msg) -> String -> Html msg
view addmsg inputmsg task =
    header
        [ class "header" ]
        [ h1 [] [ text "todos" ]
        , input
            [ class "new-todo"
            , placeholder "What needs to be done?"
            , autofocus True
            , value task
            , name "newTodo"
            , onInput inputmsg
            , onEnter addmsg
            ]
            []
        ]
