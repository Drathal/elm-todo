module Msg exposing (..)

import Todo.Msg
import Todos.Msg
import Visibility.Msg

type Msg
    = TodoMsg Int Todo.Msg.Msg
    | AddTodoMsg Todo.Msg.Msg
    | TodosMsg Todos.Msg.Msg
    | VisibilityMsg Visibility.Msg.Msg
    | NoOp
