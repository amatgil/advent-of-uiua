module Day1 exposing (day1)
import Shared exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

day1 : Html msg
day1 = div [] [ h2 [] [text "Part 1"]
              , part1
              , h2 [] [text "Part 2"]
              , part2
              , h2 [] [text "Playground"]
              , uiuaCode bothPartsEmbedLink ]

part1 : Html msg
part1 = div [] [ h3 [] [text "The Goal"]
               , p [] [ text """We're given some sequence of moves, each of which has a
                             direction (left or right) and a magnitude. Each move is to be applied
                             to a vault's dial with a hundred positions, starting at 50. For
                             example, for this input""" ]
               , verbatim sampleText
               , p [] [ text """We would have the following positions (in parentheses). Remember: we start with 50 and,
                              since the dial is circular, we always wrap back""" ]
               , verbatim sampleTextSolved
               , p [] [ text "The ultimate goal is to count the number of 0s (in this case, there's three of them)." ]


               , h3 [] [text "The Parsing"]
               , p [] [text """Parsing this input is straight-forward: for each line, we'll pull out the first
                             character (mapping it to the sign it corresponds to) and parse the rest.
                             That is, we'll partition according to where the newlines are...""" ]
               , verbatim """⊜(...)⊸≠@\n"""          
               , p [] [ text """...we'll parse the tail of each group..."""]
               , verbatim """⊙⋕°⊂"""          
               , p [] [text """...and map the head from {L, R} &rarr; {-1, 1}"""]
               , verbatim """˜⊏¯1_1⨂"LR\""""          
               , p [] [text "Which ends up looking like this:" ]
               , verbatim """˜⊏¯1_1⨂"LR"⊜(⊙⋕°⊂)⊸≠@\n"""

               , h3 [] [text "The Solution"]
               , p [] [text """This is a textbook case of modular arithmetic: we will interpret going left
                             as a negative value and going right as a positive one. We will scan across, adding the
                             values in sequence, then check which ones are equal to zero (modulo 100). The code reads
                             exactly like this english description:"""]
               , p [] [ text "We'll write it in two steps: first, we scan with addition (starting at 50): " ]
               , verbatim """\\+⊂50"""
               , p [] [ text "And then count how many values are equal to zero, modulo 100:" ]
               , verbatim "/+=₀◿₁₀₀"

               , p [] [ text "Altogether, Part 1 looks like:" ]
               , verbatim """Part₁ ← /+=₀◿₁₀₀ \\+⊂50 × Parse""" ]


part2 : Html msg
part2 = div [] [ p [] [text """We're now told that each move is actually a sequence of magnitude=1 moves. So, where
                             before we had that -1 and 10 implied that we would move -10 once, it now implies that we will now move -1 ten times.
                             We can write this change by changing the multiplication with an expansion (i.e. using ▽).
                             (Since the amount of times is behind the direction, we'll use ˜▽)."""]
               , p [] [text """So, implementing this single-function change, the final code looks like:"""]
               , verbatim """Part₂ ← /+=₀◿₁₀₀ \\+⊂50 ˜▽ Parse""" ] 



    
--parseEmbedLink : String
--parseEmbedLink = "https://uiua.org/embed?src=0_18_0-dev_3__eJxTUfAxs-BSUfAxNuBSUQgyAbNNQUwzkICPKYjtYwgiLC1BwoYmILaFEVdwYm5BTqrCo7YJXAGJRcWpCiCmwuk5j7r6D603jDd8tKJJySdI6VHXHI1HXTMfdU89tOFRV5Pmo64djzoXOMTkcUG1QczhAgACoy64"

bothPartsEmbedLink : String
bothPartsEmbedLink = "https://uiua.org/embed?src=0_18_0-dev_3__eJxTUfAxs-BSUfAxNuBSUQgyAbNNQUwzkICPKYjtYwgiLC1BwoYmILaFEVdwYm5BTqrCo7YJXFwBiUXFYKbC6TmPuvoPrTeMN3y0oknJJ0jpUdccjUddMx91Tz204VFXk-ajrh2POhc4xOSBNJU8amoEa9PXtn3U1PBo-v5HTY0gRlODQoz2o64mUwOFw9MVwMZD1TcRUn96zqNpe6Fa4HZAHAs3AsoFANsUZck="

-- part1EmbedLink : String
-- part1EmbedLink =  "https://uiua.org/embed?src=0_18_0-dev_3__eJxTUfAxs-BSUfAxNuBSUQgyAbNNQUwzkICPKYjtYwgiLC1BwoYmILaFEVdwYm5BTqrCo7YJXFwBiUXFYKbC6TmPuvoPrTeMN3y0oknJJ0jpUdccjUddMx91Tz204VFXk-ajrh2POhc4xOSBNJU8amoEa9PXtn3U1PBo-v5HTY0gRlODQoz2o64mUwOFw9MVwMbD1UMs5gIAuFxGxg=="
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
