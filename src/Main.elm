module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (..)
import Catppuccin

main =
  Browser.document { init = Model 1, update = update, view = view }

type Msg = ChangeDay Int

type Model = Model Int

update : Msg -> Model -> Model
update msg model =
  case msg of
    ChangeDay to -> Model to


view : Model -> Html Msg
view (Model day) =
  div [] [ h1 [style "height" "1em"] [ text "Holi :3" ]
         , div [ style "display" "grid"
               , style "grid-template-columns" "1fr 3fr"
               , style "color" Catppuccin.text]
            [ div [ bg Catppuccin.base , fullHeight ]
                [div [ style "display" "flex"
                     , style "flex-direction" "column"] daysList ]
            , div [ bg Catppuccin.surface0 ] [ text ("Dia és: " ++ String.fromInt day ) ] ] ]

daysList : List (Html Msg)
daysList = List.map (\n -> button [ onClick (ChangeDay n)
                                  , style "text-align" "left"
                                  , style "border" "none"
                                  , bg Catppuccin.base
                                  , style "color" Catppuccin.text]
                         [text ("Dia " ++ String.fromInt n)])
           (range 1 12)

fullHeight = style "height" "100vh"
bg         = style "background-color"
