module TodoList.Update exposing (..)

import Msg as Main exposing (..)
import TodoList.Model exposing (Model)
import TodoList.Msg exposing (..)

import Todo.Model as Todo


update : Main.Msg -> Model -> Model
update msgFor model =
    case msgFor of
        Main.MsgForTodoList msg ->
            updateTodos msg model

        _ ->
            model

updateTodos : TodoList.Msg -> Model -> Model
updateTodos msg model =
    case msg of
        Add uid task ->
            Todo.newTodo uid task :: model