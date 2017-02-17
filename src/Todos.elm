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
import AddTodo


-- MODEL


type alias Model =
    List Todo.Model


model : Model
model =
    []



-- UPDATE


type Msg
    = Add String
    | Toggle Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add task ->
            let
                newuid =
                    case List.head model of
                        Nothing ->
                            1

                        Just value ->
                            value.uid + 1
            in
                (Todo.add newuid task) :: model

        Toggle uid ->
            List.map (Todo.toggle uid) model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ AddTodo.view Add
        , ul []
            (List.map (\todo -> Todo.view (Toggle todo.uid) todo) model)
        ]
