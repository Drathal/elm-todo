module Todos
    exposing
        ( Model
        , update
        , view
        , Msg
        , model
        )

import Html exposing (Html, ul, section, input, label, text)
import Html.Attributes exposing (class, style, type_, name, checked, for)
import Todo


-- MODEL


type alias Model =
    List Todo.Model


model : Model
model =
    []



-- UPDATE


type Msg
    = Toggle Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle uid ->
            List.map (Todo.toggle uid) model



-- VIEW


view : Model -> Html Msg
view model =
    let
        emptylist =
            if List.isEmpty model then
                "hidden"
            else
                "visible"

        allCompleted =
            List.all .completed model
    in
        section
            [ class "main"
            , style [ ( "visibility", emptylist ) ]
            ]
            [ input
                [ class "toggle-all"
                , type_ "checkbox"
                , name "toggle"
                , checked allCompleted
                ]
                []
            , label
                [ for "toggle-all" ]
                [ text "Mark all as complete" ]
            , ul
                [ class "todo-list" ]
                (List.map (\todo -> Todo.view (Toggle todo.uid) todo) model)
            ]
