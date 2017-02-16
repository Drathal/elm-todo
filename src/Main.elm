module Main exposing (..)

import Html exposing (Html, map, div, text, input, button)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value, placeholder)
import Todos
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
    , todoInput : String
    }


model : Model
model =
    { todos = Todos.model
    , visibility = Visibility.model
    , todoInput = ""
    }



-- UPDATE


type Msg
    = TodosMsg Todos.Msg
    | VisibilityMsg Visibility.Msg
    | TodoInput String
    | Add String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodosMsg msg ->
            ( { model | todos = Todos.update msg model.todos }, Cmd.none )

        VisibilityMsg msg ->
            ( { model | visibility = Visibility.update msg model.visibility }, Cmd.none )

        TodoInput input ->
            ( { model | todoInput = input }, Cmd.none )

        Add input ->
            ( { model | todos = Todos.update (Todos.addTodo input) model.todos
                      , todoInput = "" 
              }, Cmd.none )



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


viewAddTodo : String -> Html Msg
viewAddTodo todoInput =
    div []
        [ input [ placeholder "Input Todo...", onInput TodoInput, value todoInput ] []
        , button [ onClick (Add todoInput) ] [ text "Add Todo" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ map (VisibilityMsg) (Visibility.view model.visibility)
        , viewAddTodo model.todoInput 
        , map (TodosMsg) (Todos.view (filterTodos model.todos model.visibility))
        ]
