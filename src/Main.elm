module Main exposing (..)

import Html exposing (Html, map, div, text)
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
            todos
        
        Visibility.Completed ->
            List.filter .completed todos

        Visibility.Active ->
            List.filter (not << .completed) todos


view : Model -> Html Msg
view model =
    div []
        [ map (VisibilityMsg) (Visibility.view model.visibility)
        , map (TodosMsg) (Todos.view (filterTodos model.todos model.visibility))
        ]
