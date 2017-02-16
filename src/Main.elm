module Main exposing (..)

import Html exposing (..)
import Counter
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
    { counter : Counter.Model
    , todos : Todos.Model
    , visibility : Visibility.Model
    }


model : Model
model =
    { counter = Counter.model
    , todos = Todos.model
    , visibility = Visibility.model
    }



-- UPDATE


type Msg
    = CounterMsg Counter.Msg
    | TodosMsg Todos.Msg
    | VisibilityMsg Visibility.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CounterMsg msg ->
            ( { model | counter = Counter.update msg model.counter }, Cmd.none )

        TodosMsg msg ->
            ( { model | todos = Todos.update msg model.todos }, Cmd.none )

        VisibilityMsg msg ->
            ( { model | visibility = Visibility.update msg model.visibility }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ map (CounterMsg) (Counter.view model.counter)
        , map (VisibilityMsg) (Visibility.view model.visibility)
        , map (TodosMsg) (Todos.view model.todos)
        , div [] [ text <| toString model.todos.todos ]
        , div [] [ text <| toString model.visibility ]
        ]
