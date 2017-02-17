module Main exposing (..)

import Html exposing (Html, map, div, section)
import Html.Attributes exposing (class, style)
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
    , uid : Int
    }


model : Model
model =
    { todos = Todos.model
    , visibility = Visibility.model
    , todoinput = ""
    , uid = 1
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
            if task == "" then
                ( model, Cmd.none )
            else
                ( { model
                    | todos = (Todo.add model.uid task) :: model.todos
                    , todoinput = ""
                    , uid = model.uid + 1
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
    let
        completed = List.length (List.filter .completed model.todos)
        left = List.length model.todos - completed
        hide = List.isEmpty model.todos
    in
        div [ class "todomvc-wrapper" ]
            [ section
                [ class "todoapp" ]
                [ AddTodo.view (Add model.todoinput) (Input) model.todoinput
                , map (TodosMsg) (Todos.view (filterTodos model.todos model.visibility))
                , map (VisibilityMsg) (Visibility.view model.visibility completed left hide)
                ]
            ]
