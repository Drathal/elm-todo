module Model exposing (..)

import TodoList.Model as TodoList

import Todo.Model

type alias Model =
    {  todolist : TodoList.Model
    }


model : Model
model =
    --{ todolist = TodoList.model
    { todolist = [ Todo.Model.Model 1 "Hello" False False
                 , Todo.Model.Model 2 "World" False False
                 , Todo.Model.Model 3 "Test" False False
                 ]
    }
