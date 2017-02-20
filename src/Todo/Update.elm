module Todo.Update exposing (..)

import Msg as Main exposing (..)
import Todo.Model exposing (Model) 
import Todo.Msg as Todo exposing (..) 

update : Main.Msg -> Model -> Model
update msgFor model =
  case msgFor of
    MsgForTodo msg ->
      updateTodo msg model

    _ ->
      model

updateTodo : Todo.Msg -> Model -> Model
updateTodo msg model =
  case msg of
    Mark uid ->
      { model | completed = (not model.completed) }