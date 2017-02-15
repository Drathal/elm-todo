module Todos exposing
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
  , content : String
  }

model : Model
model =
  Model [] ""

-- UPDATE

type Msg
  = Add
  | Change String
  | Toggle Int


update : Msg -> Model -> Model
update msg model =
  case msg of
    Add ->
      { model | todos = Todo.Model 1 model.content False :: model.todos
              , content = "" }

    Change newContent ->
      { model | content = newContent }

    Toggle uid ->
      model


-- VIEW

viewTodoItem : Todo.Model -> Html Msg
viewTodoItem todo =
  div [] [ text todo.text ]

viewAddTodo : String -> Html Msg
viewAddTodo content =
  div []
  [ input [ placeholder "Add Todo", onInput Change, value content ] []
  , button [ onClick Add ] [ text "Add" ]
  ]

view : Model -> Html Msg
view model =
  div []
    [ viewAddTodo model.content
    , div [] (List.map viewTodoItem model.todos)
    ]