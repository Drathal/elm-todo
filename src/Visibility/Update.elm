module Visibility.Update exposing (..)

import Visibility.Msg as Msg
import Visibility.Model as Model

update : Msg -> Model -> Model
update msg model =
    msg