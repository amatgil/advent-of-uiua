module Welcome exposing (welcome)
import Shared exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

welcome : Html msg
welcome = div [] [ p [] [ text "I'm "
                        , a [ href "https://github.com/amatgil"] [ text "Amat Gil" ]
                        , text ", fellow uiuan, array enjoyer, and author of "
                        , a [ href "https://github.com/amatgil/steal-gift"] [ text "steal-gift" ]
                        , text ". This page hosts my solutions for Advent of Code 2025"
                        , text ", which are written entirely in uiua (0.18.0-dev.3)."]
                 , p [] [ text """Use the sidebar on the left to select a day, each one walks through
                                the corresponding thought process and resulting code. Do note that there's an
                                embedded pad link at the end of each day with the final result, so
                                you can play around with it!""" ]
                 , p [] [ text """Whichever time of year you're reading this: Merry
                                Christmas, and happy uiuaing!"""]
                  ]
