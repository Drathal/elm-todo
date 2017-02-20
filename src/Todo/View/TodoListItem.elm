module Todo.View.TodoListItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg)
import Todo.Model exposing (Model)


view : Model -> Html Msg
view model =
    li [ classList [ ( "completed", model.complete ), ( "editing", model.editing ) ] ]
        [ div [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked model.complete
                ]
                []
            , label []
                [ text model.name ]
            , button
                [ class "destroy"
                ]
                []
            ]
        , input
            [ class "edit"
            , value model.name
            , name "title"
            , id ("todo-" ++ toString model.uid)
            ]
            []
        ]