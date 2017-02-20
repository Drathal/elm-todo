module Todo.View.TodoListItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Msg as Main exposing (Msg)
import Todo.Msg exposing (..)
import Todo.Model exposing (Model)


view : Model -> Html Main.Msg
view model =
    li [ classList [ ( "completed", model.completed ), ( "editing", model.editing ) ] ]
        [ div [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked model.completed
                , onClick (Main.MsgForTodo model.uid <| Mark (not model.completed))
                ]
                []
            , label []
                [ text model.name ]
            , button
                [ class "destroy"
                ]
                []
            ]
        , input
            [ class "edit"
            , value model.name
            , name "title"
            , id ("todo-" ++ toString model.uid)
            ]
            []
        ]