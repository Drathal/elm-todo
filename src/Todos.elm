module Todos
    exposing
        ( Model
        , update
        , view
        , Msg
        , model
        )

import Html exposing (Html, map, div, ul, input, button, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Todo
import Debug exposing (log)


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
    | TodoMsg Todo.Msg


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

        TodoMsg msg_ ->
            let
                _ =
                    Debug.log "TODOS"

                _ =
                    Debug.log (toString msg_)
            in
                model



-- VIEW


viewAddTodo : String -> Html Msg
viewAddTodo content =
    div []
        [ input [ placeholder "Add Todo", onInput Input, value content ] []
        , button [ onClick Add ] [ text "Add" ]
        ]


viewTodoItem : Todo.Model -> Html Msg
viewTodoItem todo =
    map (TodoMsg) (Todo.view todo)


view : Model -> Html Msg
view model =
    div []
        [ viewAddTodo model.input
        , ul [] (List.map viewTodoItem model.todos)
        ]
