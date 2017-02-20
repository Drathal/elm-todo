module TodoList.View exposing (..)

import Html exposing (Html, ul, li, section, input, label, text)
import Html.Attributes exposing (class, style, type_, name, checked, for)
import Msg exposing (Msg)

import TodoList.Model exposing (Model)
import Todo.View.TodoListItem as TodoView


view : Model -> Html Msg
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
                ]
                []
            , label
                [ for "toggle-all" ]
                [ text "Mark all as complete" ]
            , ul
                [ class "todo-list" ]
                (List.map TodoView.view model)
            ]