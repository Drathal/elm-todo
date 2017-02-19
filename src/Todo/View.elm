module Todo.View exposing (..)

import Msg
import Todo.Model
import Todo.Msg
import Todos.Msg
import Html exposing (Html, Attribute, li, div, input, label, button, header, h1, text)
import Html.Attributes exposing (href, class, hidden, classList, name, checked, type_, id, value, placeholder, autofocus)
import Html.Events exposing (onClick, onDoubleClick, onBlur, onInput, on, keyCode, targetValue)
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

todoEntry : Todo.Model.Model -> Html Msg.Msg
todoEntry todo =
    header [ id "header" ]
        [ h1 [] [ text "todos" ]
        , input
            [ id "new-todo"
            , placeholder "What needs to be done?"
            , autofocus True
            , value todo.text
            , name "newTodo"
            , on "input" (Json.map (Msg.TodoMsg << Todo.Msg.Update) targetValue)
            , onEnter NoOp (Msg.TodoMsg <| Todos.Msg.Add todo.uid todo.text)
            ]
            []
        ]



todoItem : Todo.Model.Model -> Html Msg.Msg
todoItem todo =
    li [ classList [ ( "completed", todo.completed ), ( "editing", todo.editing ) ] ]
        [ div [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked todo.completed
                , onClick (Msg.TodoMsg todo.id <| Todo.Msg.Check (not todo.completed))
                ]
                []
            , label [ onDoubleClick (Msg.TodoMsg todo.id <| Todo.Msg.Editing True) ]
                [ text todo.description ]
            , button
                [ class "destroy"
                , onClick (Msg.TodosMsg <| Todos.Msg.Delete todo.id)
                ]
                []
            ]
        , input
            [ class "edit"
            , value todo.description
            , name "title"
            , id ("todo-" ++ toString todo.id)
            , on "input" (Json.map (Msg.TodoMsg todo.id << Todo.Msg.Update) targetValue)
            , onBlur (Msg.TodoMsg todo.id <| Todo.Msg.Editing False)
            , onEnter NoOp (Msg.TodoMsg todo.id <| Todo.Msg.Editing False)
            ]
            []
        ]