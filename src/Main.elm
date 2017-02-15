module Main exposing (..)

import Html exposing (..)

import Counter
import Todos

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
    }

model : Model
model = 
    { counter = Counter.model
    , todos = Todos.model
    }


-- UPDATE

type Msg
  = CounterMsg Counter.Msg
  | TodosMsg Todos.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    CounterMsg msg ->
      ( { model | counter = Counter.update msg model.counter }, Cmd.none )

    TodosMsg msg ->
      ( { model | todos = Todos.update msg model.todos }, Cmd.none )

-- VIEW

view : Model -> Html Msg
view model =
  div [] 
    [ map (CounterMsg) (Counter.view model.counter)
    , map (TodosMsg) (Todos.view model.todos)
    ]