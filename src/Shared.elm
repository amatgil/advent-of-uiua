module Shared exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Catppuccin exposing (..)

verbatim : String -> Html msg
verbatim s = div [ style "white-space" "pre"
                 , style "background-color" Catppuccin.crust
                 , style "width" "min-content"
                 , style "padding" "0.2em"
                 , style "color" Catppuccin.subtext0
                 , style "font-size" "1.2em"
                 , style "margin-top" "0.5em"
                 , style "margin-bottom" "0.5em" ] [ Html.text s ]

verbatimInline : String -> Html msg
verbatimInline s = span [ style "white-space" "pre"
                        , style "background-color" Catppuccin.crust
                        , style "width" "min-content"
                        , style "padding" "0.2em"
                        , style "color" Catppuccin.subtext0 ] [ Html.text s ]
             
scanl : (a -> b -> a) -> a -> List b -> List a
scanl f acc l = case l of
               []     -> [acc]
               (x::xs) -> acc::(scanl f (f acc x) xs)
          
primitive : String -> String -> Html msg
primitive name glyph  = a [ href <| "https://uiua.org/docs/" ++ name ] [ Html.text glyph]  

uiuaCode : String -> Int -> Html msg
uiuaCode link height = iframe [ src link, style "width" "90%", style "height" (String.fromInt height ++ "em")] []

vspace : Html msg
vspace = br [] []
