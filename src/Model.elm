module Model exposing (..)

import Todos.Model
import Visibility.Model

type alias Model =
    { todos : Todos.Model
    , visibility : Visibility.Model
    }


model : Model
model =
    { todos = Todos.model
    , visibility = Visibility.model
    }