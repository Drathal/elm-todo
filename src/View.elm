module View exposing (..)

import Model exposing (Model)
import Msg exposing (Msg)
import TodoList.View as TodoListView

import Html exposing (Html, div, section, text)
import Html.Attributes exposing (class, style, id)


view : Model -> Html Msg
view model =
    div
        [ class "todomvc-wrapper"
        , style [ ( "visibility", "hidden" ) ]
        ]
        [ section [ id "todoapp" ]
            [ TodoListView.view model.todolist
            , text (toString model.todolist)
            ]
        ]