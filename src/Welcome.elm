module Welcome exposing (welcome)
import Shared exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

welcome : Html msg
welcome = div [] [ p [] [ text "Todo: welcome text" ]
                 , vspace
                 , p [] [text "Use the sidebar to select a day"]
                 , p [] [text "Mention playground at the end of every day"]
                  ]
