module Msg exposing (..)

import TodoList.Msg as TodoList


type Msg
  = NoOp
  | TodoListMsg TodoList.Msg