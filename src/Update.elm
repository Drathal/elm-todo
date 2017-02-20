module Update exposing (..)


import Msg exposing (Msg)
import Model exposing (Model)
import TodoList.Update as TodoList

update : Msg -> Model -> Model
update msg model =
  { model | todolist = TodoList.update msg model.todolist }