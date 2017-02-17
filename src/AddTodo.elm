module AddTodo exposing (..)

import Html exposing (Html, form, input, button, text)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (type_)


type alias Model =
    String


type Msg
    = Input String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input task ->
            task


view : (String -> msg) -> Html msg
view msg =
    form []
        [ input [ type_ "text" ] []
        , button [ onClick (msg "HELLO") ] [ text "Add" ]
        ]
