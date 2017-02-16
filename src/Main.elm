module Main exposing (..)

import Html exposing (Html, map, div, text, input, button)
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
    }


model : Model
model =
    { todos = Todos.model
    , visibility = Visibility.model
    }



-- UPDATE


type Msg
    = TodosMsg Todos.Msg
    | VisibilityMsg Visibility.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodosMsg msg ->
            ( { model | todos = Todos.update msg model.todos }, Cmd.none )

        VisibilityMsg msg ->
            ( { model | visibility = Visibility.update msg model.visibility }, Cmd.none )



-- VIEW


filterTodos : Todos.Model -> Visibility.Model -> Todos.Model
filterTodos todos visibility =
    case visibility of
        Visibility.All ->
            { todos | todos = todos.todos }

        Visibility.Completed ->
            { todos | todos = List.filter .completed todos.todos }

        Visibility.Active ->
            { todos | todos = List.filter (not << .completed) todos.todos }


view : Model -> Html Msg
view model =
    div []
        [ map (VisibilityMsg) (Visibility.view model.visibility)
        , map (TodosMsg) (Todos.view (filterTodos model.todos model.visibility))
        ]
