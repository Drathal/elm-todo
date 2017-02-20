module Model exposing (..)

import TodoList.Model as TodoList


type alias Model =
    { todolist : TodoList.Model
    }


model : Model
model =
    { todolist = TodoList.model
    }