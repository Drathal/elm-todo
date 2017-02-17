module Todo exposing (..)

import Html exposing (Html, li, text, div, input, label, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (classList, class, name, id, checked, type_, value)


type alias Model =
    { uid : Int
    , text : String
    , completed : Bool
    , editing : Bool
    }


add : Int -> String -> Model
add uid task =
    Model uid task False False


toggle : Int -> Model -> Model
toggle uid todo =
    if todo.uid == uid then
        { todo | completed = not todo.completed }
    else
        todo


view : msg -> msg -> Model -> Html msg
view togglemsg deletemsg todo =
    li
        [ classList [ ( "completed", todo.completed ), ( "editing", todo.editing ) ] ]
        [ div
            [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked todo.completed
                , onClick togglemsg
                ]
                []
            , label
                []
                [ text todo.text ]
            , button
                [ class "destroy"
                , onClick deletemsg
                ]
                []
            ]
        , input
            [ class "edit"
            , value todo.text
            , name "title"
            , id ("todo-" ++ toString todo.uid)
            ]
            []
        ]
