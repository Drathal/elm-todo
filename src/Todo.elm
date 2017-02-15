module Todo exposing (..)


type alias Model =
  { uid : Int
  , text : String
  , completed : Bool
  }