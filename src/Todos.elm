module Todos
    exposing
        ( Model
        , update
        , view
        , Msg
        , model
        )

import Html exposing (Html, map, div, ul, li, input, button, text)
import Todo


-- MODEL


type alias Model =
    List Todo.Model


model : Model
model =
    []



-- UPDATE


type Msg
    = Toggle Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle uid ->
            List.map (Todo.toggle uid) model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ ul []
            (List.map (\todo -> Todo.view (Toggle todo.uid) todo) model)
        ]
