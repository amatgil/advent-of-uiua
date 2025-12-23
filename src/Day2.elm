module Day2 exposing (day2)
import Shared exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

day2 : Html msg
day2 = div [] [ h2 [] [text "Part 1"]
              , part1
              , h2 [] [text "Part 2"]
              , part2
              , h2 [] [text "Playground"]
              , uiuaCode bothPartsEmbedLink ]

part1 : Html msg
part1 = div [] [ p [] [ text "Given some sequence of ranges, like the following comma-separated ranges" ]
               , verbatim <| String.left 50 sample ++ "..."
               , p [] [ text """We are to sum up all values in each (inclusive) range that are "invalid", where
                              a number is valid if they look like XXXYYY (in base ten), with equal amounts
                              of Xs and Ys. For example, the range """
                      , verbatimInline "11-22"
                      , text """ contains two invalid IDs: """
                      , verbatimInline "11"
                      , text " and "
                      , verbatimInline "22"
                      , text ". Similarly, "
                      , verbatimInline  "95-115"
                      , text """ has one invalid ID: """
                      , verbatimInline "99"
                      , text "." ]
               , vspace
               , p [] [ text """Let's get the parsing out of the way, first: we'll partition on the
                              commas and, for each group, parse each of the groups that are separated by
                              the hyphen as numbers. All together, this looks like:"""]
               , verbatim """⊜(⊜⋕⊸≠@-)⊸≠@,"""
               , vspace
               ,
               ]




sample = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

part2 : Html msg
part2 = div [] [ text "TODO" ] 



    
bothPartsEmbedLink : String
bothPartsEmbedLink = "https://uiua.org/embed?src=0_18_0-dev_3__eJxVUMFKAzEQvecrInrI0oRussluchC8eBd6FwoWFKxI8eC1K9Ru2oKXaguFulCoF6EHQUG8tH_yvkR2twuaCfNehjczjxzS0_vbTu-q27m5a18fkCMqpVCKOyOkNNw5K2QoFZfSWlOkUNTUhVwVJxQlaC5jZ41SokLLtY61jkQJjkfWuMiaWFQkVtzEJjaRKMFxq3R5pahZwpWsQlpRU6VJq929ve5QDJ4IaV22e52Lg-JBGaEUfsHgFxhN4b-QvZ6IYE84obTZQJazZgPPP2U1Z-fhdoPRNMBkIfCYw88bSPvbDfwyIAEhZ-3eHdJ-OX-_iyGbwD9gMMdgBv_FMPa7T6Qp1t9BsO9I_3U0MXzD_B1ZjvGSHSPtY_2Nlw-shxjOtqvtqnDJKlvsuPA29sHusywOZoX-MUfaD6oVBJMVVnNkEyqVSpLEGKNpbbX6nj8aLRMdJU7FZq9Ja80vcLfJHg=="
