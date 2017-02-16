module Todos
    exposing
        ( Model
        , update
        , view
        , Msg
        , model
        )

import Html exposing (Html, map, div, ul, li, input, button, text)
import Html.Attributes exposing (placeholder, value, classList)
import Html.Events exposing (onClick, onInput)
import Todo


-- MODEL


type alias Model =
    List Todo.Model


model : Model
model =
    [ Todo.Model 1 "Hello" False
    , Todo.Model 2 "World" False
    , Todo.Model 3 "Meatballs" False
    ]



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
                (Todo.Model newuid task False) :: model

        Toggle uid ->
            let
                updateTodo todo =
                    if todo.uid == uid then
                        { todo | completed = not todo.completed }
                    else
                        todo
            in
                List.map updateTodo model



-- VIEW


viewTodoItem : Todo.Model -> Html Msg
viewTodoItem todo =
    li [ onClick (Toggle todo.uid), classList [ ( "selected", todo.completed ) ] ]
        [ text todo.text ]


view : Model -> Html Msg
view model =
    div []
        [ ul [] (List.map viewTodoItem model)
        ]
