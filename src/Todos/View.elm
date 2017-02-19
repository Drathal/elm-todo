module Todos.View exposing (..)

import Html exposing (Html, ul, section, input, label, text)
import Html.Attributes exposing (class, style, type_, name, checked, for)
import Html.Events exposing (onClick)
import Dom
import Msg
import Todos.Model

view : Todos.Model -> Html Msg
view model =
    let
        emptylist =
            if List.isEmpty model then
                "hidden"
            else
                "visible"

        allCompleted =
            List.all .completed model
    in
        section
            [ class "main"
            , style [ ( "visibility", emptylist ) ]
            ]
            [ input
                [ class "toggle-all"
                , type_ "checkbox"
                , name "toggle"
                , checked allCompleted
                , onClick (MarkAll (not allCompleted))
                ]
                []
            , label
                [ for "toggle-all" ]
                [ text "Mark all as complete" ]
            , ul
                [ class "todo-list" ]
                (List.map (Todo.view (Toggle) (Delete) (Edit) (Update)) model)
            ]