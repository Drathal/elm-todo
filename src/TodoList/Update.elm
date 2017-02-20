module TodoList.Update exposing (..)

import Msg as Main exposing (..)
import TodoList.Model as TodoList
import TodoList.Msg as TodoListMsg

import Todo.Model as Todo


update : Main.Msg -> TodoList.Model -> TodoList.Model
update msg model =
    case msg of
        Main.TodoListMsg todosmsg ->
            updateTodos todosmsg model

        _ ->
            model

updateTodos : TodoListMsg.Msg -> TodoList.Model -> TodoList.Model
updateTodos msg model =
    case msg of
        TodoListMsg.Add uid task ->
            Todo.newTodo uid task :: model