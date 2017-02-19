module Todos.Update exposing (..)

import Msg as Main exposing (..)
import Todo.Model
import Todos.Model exposing (Model)
import Todos.Msg


update : Main.Msg -> Model -> Model
update msgFor model =
    case msgFor of
        TodosMsg msg ->
            updateTodos msg model

updateTodos : Todos.Msg -> Model -> Model
updateTodos msg model =
    case msg of
        Add uid task ->
            Todo.Model uid task False False :: model

        Delete uid ->
            let
                remove todo =
                    todo.uid == uid
            in
                List.filter (not << remove) model

        DeleteComplete ->
            List.filter (.completed) model

        CheckAll allCompleted ->
            let
                update todo =
                    { todo | completed = allCompleted }
            in
                List.map update model

updateTodo : Int -> Todo.Model.Model -> Model
updateTodo uid msg todos =
    let
      update todo =
        if todo.uid == uid then
            Update msg todo
        else
            todo
    in
        List.map update todos
