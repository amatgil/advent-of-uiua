module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (..)
import Catppuccin
import Welcome exposing (..)
import Day1 exposing (..)
import Day2 exposing (..)

main : Program () Model Msg
main = Browser.sandbox { init = Model 0
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
            , style "color" Catppuccin.text
            , style "margin-left" "0.3em" ] [ text "Advent of Uiua" ]
         , div [ style "display" "grid"
               , style "grid-template-columns" "1fr 4fr"
               , style "color" Catppuccin.text]
            [ div [ style "background-color" Catppuccin.base ]
                [div [ style "display" "flex"
                     , style "flex-direction" "column"] daysSelectList ]
            , displayDay day ] ]

daysSelectList : List (Html Msg)
daysSelectList = ("Welcome", 0) :: List.map (\n -> ("Day " ++ String.fromInt n, n)) (range 1 12) |>
                   List.map (\(t, n) -> button [ onClick (ChangeDay n)
                                          , style "text-align" "left"
                                          , style "border" "none"
                                          , style "background-color" Catppuccin.base
                                          , style "color" Catppuccin.text
                                          , style "font-size" "1.5em"
                                          , style "padding-top" "0.3em"
                                          , style "padding-bottom" "0.3em"
                                          , class "day-button"]
                                        [ span [ style "margin-left" "0.2em"] [text t ]])
                 

               
displayDay : Int -> Html msg
displayDay day = div [ style "background-color" Catppuccin.surface0
                     , style "padding-left" "1em"
                     , style "max-width" "43em"
                     , style "font-size" "1.2em"]
                  [ h1 [] [ if day == 0 then text "Welcome!" else  text ("Day" ++ String.fromInt day)]
                  , case day of
                    0 -> welcome
                    1 -> day1
                    2 -> day2
                    _ -> div [] [ p [] [text "This day has not yet been written up!"] ]
                  ] 
