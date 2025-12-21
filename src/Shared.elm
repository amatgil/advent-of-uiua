module Shared exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Catppuccin exposing (..)

verbatim : String -> Html msg
verbatim s = div [ style "white-space" "pre"
                 , style "background-color" Catppuccin.crust
                 , style "width" "min-content"
                 , style "padding" "0.2em"
                 , style "color" Catppuccin.subtext0 ] [ Html.text s ]

scanl : (a -> b -> a) -> a -> List b -> List a
scanl f acc l = case l of
               []     -> [acc]
               (x::xs) -> acc::(scanl f (f acc x) xs)
          
          
