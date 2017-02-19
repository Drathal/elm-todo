module Todo.Model exposing (..)


type alias Model =
    { uid : Int
    , text : String
    , completed : Bool
    , editing : Bool
    }


newTodo : Int -> String -> Model
newTodo uid task =
    Model uid task False False