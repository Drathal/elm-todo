module Todo.Update exposing (..)

import Msg
import Todo.Msg
import Todos.Msg
import Todo.Model


update : Msg.Msg -> Todo.Model.Model -> Todo.Model.Model
update msgFor task =
    case msgFor of
        Msg.TodoMsg _ msg ->
            updateTodo msg task

        Msg.AddTodoMsg msg ->
            updateTodo msg task

        Msg.TodosMsg (Todos.Msg.Add uid _) ->
            Todo.Model.newTodo (uid + 1) ""

        _ ->
            task

updateTodo : Todo.Msg.Msg -> Todo.Model.Model -> Todo.Model.Model
updateTodo msg model =
    case msg of
        Todo.Msg.Check isCompleted ->
            { model | completed = isCompleted }

        Todo.Msg.Editing isEditing ->
            { model | editing = isEditing }

        Todo.Msg.Update task ->
            { model | text = task }
