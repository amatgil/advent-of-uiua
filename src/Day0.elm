module Day0 exposing (day0)
import Shared exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

day0 : Html msg
day0 = div [] [ p [] [ text "Todo: welcome text" ]
              , vspace
              , p [] [text "Use the sidebar to select a day"]
              , p [] [text "Mention playground at the end of every day"]
               ]
