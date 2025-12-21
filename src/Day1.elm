module Day1 exposing (day1)
import Shared exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

day1 : Html msg
day1 = div [] [
        h2 [] [text "Part 1"]

        , h3 [] [text "The Goal"]
        , p [] [ text """We're given some sequence of moves, each of which has a
                      direction (left or right) and a magnitude. Each move is to be applied
                      to a vault's dial with a hundred positions, starting at 50. For
                      example, for this input""" ]
        , verbatim sampleText
        , p [] [ text """We would have the following positions (in parentheses). Remember: we start with 50 and,
                       since the dial is circular, we always wrap back""" ]
        , verbatim sampleTextSolved
        , p [] [ text "The ultimate goal is to count the number of 0s (in this case, there's three of them)." ]


        , h3 [] [text "The Solution"]
        , p [] [text """This is a textbook case of modular arithmetic: we will interpret going left
                      as a negative value and going right as a positive one. We will scan across, adding the
                      values in sequence, then check which ones are equal to zero (modulo 100). The code reads
                      exactly like this english description (after parsing, of course):"""]
        , p [] [ text "We'll write it in two steps: first, we scan with addition (starting at 50): " ]
        , verbatim "\\+⊂50"
        , p [] [ text "And then count how many values are equal to zero, modulo 100:" ]
        , verbatim "/+=₀◿₁₀₀"

        , p [] [ text "Altogether, Part 1 looks like:" ]
        , iframe [ src part1EmbedLink, style "width" "90%", style "height" "30em"] []

       ]

part1EmbedLink : String
part1EmbedLink =  "https://uiua.org/embed?src=0_18_0-dev_3__eJxTUfAxs-BSUfAxNuBSUQgyAbNNQUwzkICPKYjtYwgiLC1BwoYmILaFEVdwYm5BTqrCo7YJXFwBiUXFYKbC6TmPuvoPrTeMN3y0oknJJ0jpUdccjUddMx91Tz204VFXk-ajrh2POhc4xOSBNJU8amoEa9PXtn3U1PBo-v5HTY0gRlODQoz2o64mUwOFw9MVwMbD1UMs5gIAuFxGxg=="
-- /+=₀◿₁₀₀ \+⊂50 × Parse

sample : List ( String, number )
sample = [("L", 68),("L", 30),("R", 48),("L", 5),("R", 60),("L", 55),("L", 1),("L", 99),("R", 14),("L", 82)]

sampleText : String
sampleText =  List.map (\((dir, mag)) -> dir ++ String.fromInt mag) sample
           |> List.intersperse "\n"
           |> List.foldl (\x acc -> acc ++ x) ""

sampleTextSolved : String
sampleTextSolved = let answer_col = List.map (\((dir, mag)) -> ((if dir == "R" then 1 else -1)*mag)) sample
                                    |> scanl (+) 50
                                    |> List.map (modBy 100)
                                    |> List.map String.fromInt
                                    |> List.drop 1
                       bare = List.map (\((dir, mag)) -> dir ++ String.fromInt mag ) sample
                   in List.map2 (\left right -> String.padRight 5 ' ' left ++ "->" ++ String.padLeft 5 ' ' ("(" ++ right ++ ")") ) bare answer_col
                       |> List.intersperse "\n"
                       |> List.foldl (\x acc -> acc ++ x) ""
