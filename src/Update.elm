module Update exposing (..)

import Msg
import Model
import Todo.Update
import Todos.Update


update : Msg.Msg -> Model.Model -> Model.Model
update msg model =
    { model
        | todoEntry = Todo.Update.update msg model.todoEntry
        , todos = Todos.Update.update msg model.todos
    }