module Todo exposing (..)

import Html exposing (Html, li, text)
import Html.Attributes exposing (classList)
import Html.Events exposing (onClick)

-- Model

type alias Model =
    { uid : Int
    , text : String
    , completed : Bool
    }


-- Update

type Msg
    = Toggle Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle todo ->
            { todo | completed = not todo.completed }


-- View

view : Model -> Html Msg
view todo =
    li [ onClick (Toggle todo), classList [ ( "selected", todo.completed ) ] ]
        [ text todo.text ]