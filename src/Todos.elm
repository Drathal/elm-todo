module Todos
    exposing
        ( Model
        , update
        , view
        , Msg
        , model
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Todo


-- MODEL


type alias Model =
    { todos : List Todo.Model
    , input : String
    }


model : Model
model =
    Model [] ""



-- UPDATE


type Msg
    = Add
    | Input String
    | Toggle Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            let
                newuid =
                    case List.head model.todos of
                        Nothing ->
                            1

                        Just value ->
                            value.uid + 1
            in
                if model.input == "" then
                    model
                else
                    { model
                        | todos = Todo.Model newuid model.input False :: model.todos
                        , input = ""
                    }

        Input input ->
            { model | input = input }

        Toggle uid ->
            let
                updateTodo todo =
                    if todo.uid == uid then
                        { todo | completed = not todo.completed }
                    else
                        todo
            in
                { model | todos = List.map updateTodo model.todos }



-- VIEW


viewTodoItem : Todo.Model -> Html Msg
viewTodoItem todo =
    li [ onClick (Toggle todo.uid), classList [ ( "selected", todo.completed ) ] ]
        [ text todo.text ]


viewAddTodo : String -> Html Msg
viewAddTodo content =
    div []
        [ input [ placeholder "Add Todo", onInput Input, value content ] []
        , button [ onClick Add ] [ text "Add" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ viewAddTodo model.input
        , ul [] (List.map viewTodoItem model.todos)
        ]
