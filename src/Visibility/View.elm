module Visibility.View exposing (..)

import Msg
import Visibility.Msg
import Visibility.Model
import Html exposing (..)
import Html.Attributes exposing (href, class, hidden, classList)
import Html.Events exposing (onClick)


viewVisibility : Visibility.Msg -> Visibility.Msg -> Html Msg.Msg
viewVisibility current visibility =
    li
        [ onClick visibility ]
        [ a [ href "#", classList [ ( "selected", visibility == current ) ] ]
            [ text (toString visibility) ]
        ]

viewLeftTodos : Int -> Html Msg.Msg
viewLeftTodos left =
    let
        item_ =
            if left == 1 then
                " item"
            else
                " items"
    in
        span
            [ class "todo-count" ]
            [ strong [] [ text (toString left) ]
            , text (item_ ++ " left")
            ]

viewCompleted : Int -> Html Msg.Msg
viewCompleted completed =
    button
        [ class "clear-completed"
        , hidden (completed == 0)
        ]
        [ text ("Clear completed (" ++ toString completed ++ ")")
        ]

view : Visibility.Model -> Int -> Int -> Bool -> Html Msg.Msg
view model completed left hide =
    footer
        [ class "footer"
        , hidden hide ]
        [ viewLeftTodos left
        , ul [ class "filters" ] (List.map (viewVisibility model) [ All, Completed, Active ])
        , viewCompleted completed
        ]