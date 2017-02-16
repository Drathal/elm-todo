module Visibility exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)


-- Messages 

type Msg
    = All
    | Completed
    | Active


-- MODEL

type alias Model = Msg

model : Model
model = All


-- Update

update : Msg -> Model -> Model
update msg model =
    case msg of
        All ->
            All
        
        Completed ->
            Completed
        
        Active ->
            Active


-- VIEW

visibilityToString : Msg -> String
visibilityToString visibility =
    case visibility of
        All ->
            "All"

        Completed ->
            "Completed"

        Active ->
            "Active"


viewVisibility : Msg -> Msg -> Html Msg
viewVisibility current visibility =
    if visibility == current then
        span []
            [ text (visibilityToString visibility)
            ]
    else
        a [ href "#", onClick visibility ]
            [ text (visibilityToString visibility)
            ]


view : Model -> Html Msg
view currentVisibility =
    div []
        (List.map (viewVisibility currentVisibility) [ All, Completed, Active ])
