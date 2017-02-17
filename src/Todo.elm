module Todo exposing (..)


type alias Model =
    { uid : Int
    , text : String
    , completed : Bool
    }


add : Int -> String -> Model
add uid task =
    Model uid task False


toggle : Int -> Model -> Model
toggle uid todo =
    if todo.uid == uid then
        { todo | completed = not todo.completed }
    else
        todo
