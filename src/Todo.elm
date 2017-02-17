module Todo exposing (..)

import Html exposing (Html, li, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (classList)


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


view : msg -> Model -> Html msg
view msg todo =
    li
        [ onClick msg
        , classList [ ( "selected", todo.completed ) ]
        ]
        [ text todo.text ]
