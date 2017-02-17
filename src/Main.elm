module Main exposing (..)

import Html exposing (Html, map, div, text, input, button)
import Html.Attributes exposing (value, type_)
import Html.Events exposing (onClick, onInput)
import Todo
import Todos
import AddTodo
import Visibility


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }



-- MODEL


type alias Model =
    { todos : Todos.Model
    , visibility : Visibility.Model
    , todoinput : String
    }


model : Model
model =
    { todos = Todos.model
    , visibility = Visibility.model
    , todoinput = ""
    }



-- UPDATE


type Msg
    = TodosMsg Todos.Msg
    | VisibilityMsg Visibility.Msg
    | Input String
    | Add String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodosMsg msg ->
            ( { model | todos = Todos.update msg model.todos }, Cmd.none )

        VisibilityMsg msg ->
            ( { model | visibility = Visibility.update msg model.visibility }, Cmd.none )

        Input todoinput ->
            ( { model | todoinput = todoinput }, Cmd.none )

        Add task ->
            let
                newuid =
                    case List.head model.todos of
                        Nothing ->
                            1

                        Just value ->
                            value.uid + 1
            in
                ( { model
                    | todos = (Todo.add newuid task) :: model.todos
                    , todoinput = ""
                  }
                , Cmd.none
                )



-- VIEW


filterTodos : Todos.Model -> Visibility.Model -> Todos.Model
filterTodos todos visibility =
    case visibility of
        Visibility.All ->
            todos

        Visibility.Completed ->
            List.filter .completed todos

        Visibility.Active ->
            List.filter (not << .completed) todos


view : Model -> Html Msg
view model =
    div []
        [ map (VisibilityMsg) (Visibility.view model.visibility)
        , AddTodo.view (Add model.todoinput) (Input) model.todoinput
        , map (TodosMsg) (Todos.view (filterTodos model.todos model.visibility))
        ]
