module TodoList.Model exposing (..)

import Todo.Model as Todo

type alias Model =
    List Todo.Model


model : Model
model =
    [ Todo.Model 1 "Hello" False False
    , Todo.Model 2 "World" False False
    , Todo.Model 3 "Test" False False
    , Todo.Model 4 "Yogurt" False False
    ]