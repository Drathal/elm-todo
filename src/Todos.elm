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
    { todos : List Todo.Model
    , todoInput : String
    }


model : Model
model =
    { todos = []
    , todoInput = ""
    }



-- UPDATE


type Msg
    = Add String
    | Toggle Int
    | TodoInput String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add task ->
            let
                newuid =
                    case List.head model.todos of
                        Nothing ->
                            1

                        Just value ->
                            value.uid + 1
            in
                { model
                    | todos = (Todo.add newuid task) :: model.todos
                    , todoInput = ""
                }

        Toggle uid ->
            { model | todos = List.map (Todo.toggle uid) model.todos }

        TodoInput input ->
            { model | todoInput = input }



-- VIEW


viewAddTodo : String -> Html Msg
viewAddTodo todoInput =
    div []
        [ input [ placeholder "Input Todo...", onInput TodoInput, value todoInput ] []
        , button [ onClick (Add todoInput) ] [ text "Add Todo" ]
        ]


viewTodoItem : Todo.Model -> Html Msg
viewTodoItem todo =
    li [ onClick (Toggle todo.uid), classList [ ( "selected", todo.completed ) ] ]
        [ text todo.text ]

<<<<<<< HEAD
=======

>>>>>>> 6121219178382535251e2d59e3b1d8afa0857e7a
view : Model -> Html Msg
view model =
    div []
        [ viewAddTodo model.todoInput
        , ul [] (List.map viewTodoItem model.todos)
        ]
