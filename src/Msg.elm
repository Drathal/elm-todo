module Msg exposing (..)

import Todo.Msg as Todo
import TodoList.Msg as TodoList


type Msg
  = NoOp
  | MsgForTodo Int Todo.Msg
  | MsgForTodoList TodoList.Msg