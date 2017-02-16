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


type alias Model =
    Msg


model : Model
model =
    All



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


viewVisibility : Msg -> Msg -> Html Msg
viewVisibility current visibility =
    if visibility == current then
        span []
            [ text (toString visibility)
            ]
    else
        a [ href "#", onClick visibility ]
            [ text (toString visibility)
            ]


view : Model -> Html Msg
view model =
    div []
        (List.map (viewVisibility model) [ All, Completed, Active ])
