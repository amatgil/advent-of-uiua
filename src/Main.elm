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
                     , style "flex-direction" "column"] daysList ]
            , displayDay day ] ]

daysList : List (Html Msg)
daysList = List.map (\n -> button [ onClick (ChangeDay n)
                                  , style "text-align" "left"
                                  , style "border" "none"
                                  , style "background-color" Catppuccin.base
                                  , style "color" Catppuccin.text
                                  , style "font-size" "1.5em"
                                  , style "padding-top" "0.3em"
                                  , style "padding-bottom" "0.3em"
                                  , class "day-button"]
                         [text ("Day " ++ String.fromInt n)])
           (range 1 12)

               
displayDay : Int -> Html msg
displayDay day = div [ style "background-color" Catppuccin.surface0 ]
                 [ text ("Dia és: " ++ String.fromInt day ) ] 
