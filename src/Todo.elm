module Todo exposing (..)

import Html exposing (Html, Attribute, li, text, div, input, label, button)
import Html.Events exposing (onClick, onInput, onDoubleClick, onBlur, keyCode, on)
import Html.Attributes exposing (classList, class, name, id, checked, type_, value)
import Json.Decode as Json


onEnter : msg -> Attribute msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg
            else
                Json.fail "not ENTER"
    in
        on "keydown" (Json.andThen isEnter keyCode)



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


view : (Int -> msg)
   -> (Int -> msg)
   -> (Int -> Bool -> msg )
   -> (Int -> String -> msg)
   -> Model
   -> Html msg
view togglemsg deletemsg editmsg updatemsg todo =
    li
        [ classList [ ( "completed", todo.completed ), ( "editing", todo.editing ) ] ]
        [ div
            [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked todo.completed
                , onClick (togglemsg todo.uid)
                ]
                []
            , label
                [ onDoubleClick (editmsg todo.uid True) ]
                [ text todo.text ]
            , button
                [ class "destroy"
                , onClick (deletemsg todo.uid)
                ]
                []
            ]
        , input
            [ class "edit"
            , value todo.text
            , name "title"
            , id ("todo-" ++ toString todo.uid)
            , onBlur (editmsg todo.uid False)
            , onEnter (editmsg todo.uid False)
            , onInput (updatemsg todo.uid)
            ]
            []
        ]
