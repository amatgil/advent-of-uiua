module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (..)
import Catppuccin

main : Program () Model Msg
main = Browser.sandbox { init = Model 1
                       , update = update
                       , view = view }

type Msg = ChangeDay Int

type Model = Model Int

update : Msg -> Model -> Model
update msg _ = case msg of
                   ChangeDay to -> Model to


view : Model -> Html Msg
view (Model day) =
  div [] [ h1 [ style "height" "1em"
            , style "color" Catppuccin.text ] [ text "Advent of Uiua" ]
         , div [ style "display" "grid"
               , style "grid-template-columns" "1fr 4fr"
               , style "color" Catppuccin.text]
            [ div [ style "background-color" Catppuccin.base
                  , style "height" "100vh"]
                [div [ style "display" "flex"
                     , style "flex-direction" "column"] daysSelectList ]
            , displayDay day ] ]

daysSelectList : List (Html Msg)
daysSelectList = List.map (\n -> button [ onClick (ChangeDay n)
                                        , style "text-align" "left"
                                        , style "border" "none"
                                        , style "background-color" Catppuccin.base
                                        , style "color" Catppuccin.text
                                        , style "font-size" "1.5em"
                                        , style "padding-top" "0.3em"
                                        , style "padding-bottom" "0.3em"
                                        , class "day-button"]
                              [ text ("Day " ++ String.fromInt n) ])
                 (range 1 12)

               
displayDay : Int -> Html msg
displayDay day = div [ style "background-color" Catppuccin.surface0 ]
                  [ p [] [text ("Dia és: " ++ String.fromInt day )] ] 


day1 = div [] [
        
        ]

-- # Experimental!
-- ~ "git: github.com/amatgil/steal-gift" ~ AoCGet
-- 
-- # ====== INPUTS ======
-- Input ← AoCGet 2025 1
-- 
-- $ L68
-- $ L30
-- $ R48
-- $ L5
-- $ R60
-- $ L55
-- $ L1
-- $ L99
-- $ R14
-- $ L82
-- Sample ←
-- 
-- Parse ← ˜⊏¯1_1⨂"LR"⊜(⊙⋕°⊂)⊸≠@\n
-- Part₁ ← /+=₀◿₁₀₀ \+⊂50 × Parse
-- Part₂ ← /+=₀◿₁₀₀ \+⊂50 ˜▽ Parse
-- 
-- ⍤⤙≍ 3 Part₁ Sample
-- ⍤⤙≍ 6 Part₂ Sample
