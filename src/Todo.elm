module Todo exposing (..)

import Html exposing (Html, text, li)
import Html.Attributes exposing (classList)


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
            let
                _ =
                    Debug.log "HELLO"

                _ =
                    Debug.log (toString todo)
            in
                { todo | completed = not todo.completed }



-- View


view : Model -> Html Msg
view todo =
    li [ classList [ ( "selected", todo.completed ) ] ]
       [ text todo.text
       ]
