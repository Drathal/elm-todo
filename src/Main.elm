module Main exposing (..)

import Html exposing (Html, map, div, section)
import Model
import Msg

main : Program Never Model.Model Msg.Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
