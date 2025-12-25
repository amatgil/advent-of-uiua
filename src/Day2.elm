module Day2 exposing (day2)
import Shared exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

day2 : Html msg
day2 = div [] [ h2 [] [text "Part 1"]
              , part1
              , vspace
              , h2 [] [text "Part 2"]
              , part2
              , h2 [] [text "Playground"]
              , uiuaCode bothPartsEmbedLink 24 ]

sample = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

part1 : Html msg
part1 = div [] [ p [] [ text "Given some sequence of ranges, like the following comma-separated ranges" ]
               , verbatim <| String.left 50 sample ++ "..."
               , p [] [ text """We are to sum up all values in each (inclusive) range that are "invalid", where
                              a number is invalid if it looks like two equal sequences of
                              digits (in base ten). For example, the range """
                      , verbatimInline "11-22"
                      , text """ contains two invalid IDs: """
                      , verbatimInline "11"
                      , text " and "
                      , verbatimInline "22"
                      , text ". Similarly, "
                      , verbatimInline  "95-115"
                      , text """ has one invalid ID: """
                      , verbatimInline "99"
                      , text "; and "
                      , verbatimInline "1188511880-1188511890"
                      , text " also has one: "
                      , verbatimInline "1188511885"
                      , text "." ]
               , vspace
               , p [] [ text """Let's get the parsing out of the way, first: we'll partition on the
                              commas and, for each group, parse each of the groups that are separated by
                              the hyphen as numbers. All together, this looks like:"""]
               , verbatim """⊜(⊜⋕⊸≠@-)⊸≠@,"""
               , vspace
               , p [] [ text """Now, with the parsing done, we'll prepare the check for if a number
                              is invalid. We'll go through its string
                              representation and check if both halves match. This is:"""
               , verbatim """°⋕         # Unparse (i.e. turn into a string)
⊃↙↘⊸(⌊÷₂⧻) # Split in half
≍          # Do they match? """
               , p [] [ text "In one line:" ]
               , verbatim """≍⊃↙↘⊸(⌊÷₂⧻)°⋕"""]
               , vspace
               , p [] [ text """Now, we will keep the values of each inclusive range and
                              add up what remains. Once again, ▽ is the tool for the job: we
                              will 'keep by the invalidness check of each value in the range': this is, we will """
                      , verbatimInline "▽⊸≡(InvalidnessCheck)"
                      , text ", and so:" ]
               , verbatim """⍜-⇡ ⊙+₁            # Get all values in range (inclusive)
▽⊸≡(≍⊃↙↘⊸(⌊÷₂⧻)°⋕) # Keep all invalid values
/+                 # Sum"""
               , p [] [ text "Finally, we run this on each of the ranges of the input (with "
                      , primitive "rows" "≡"
                       , text ")." ]
               , verbatim """⊜(⊜⋕⊸≠@-)⊸≠@,                     # Parse
/+≡(/+▽⊸≡(≍⊃↙↘⊸(⌊÷₂⧻)°⋕)⍜-⇡⊙+₁°⊟) # Sum the sums
                                  #  of invalids"""
               ]

-- Shared! ← (
--   ⊜(⊜⋕⊸≠@-)⊸≠@,
--   /+≡(/+▽⊸≡(^0°⋕)⍜-⇡⊙+₁°⊟)
-- )
-- 
-- Part₁ ← Shared!(≍⊃↙↘⊸(⌊÷₂⧻))
-- Part₂ ← Shared!(/∨♭≡⌟(=₁⧻◴⧈∘¤¤)⊸(▽⊸(=⊸⌊)÷⊸(↘₁⇡₁)⧻))


part2 : Html msg
part2 = div [] [ p [] [ text """Part 2 changes the invalidness check: instead of splitting the number
                              in half, we must check every possible splitting position. For example, """
                      , verbatimInline "12341234"
                      , text " is still invalid, but so is "
                      , verbatimInline "123123123"
                      , text " and "
                      , verbatimInline "1111111"
                      , text "."] 
               , p [] [ text """To show the connection between Part 1 and Part 2 (since only the
                             invalidness check changes), we will factor out the summing-up
                              part using a macro.""" ]
               , p [] [ text """With this change, Part 1 looks like this (note the
                              invalidness check from earlier inside that """
                      , verbatimInline  "Part₁"
                      , text """ binding and """
                      , verbatimInline "^0"
                      , text """ in the """
                      , verbatimInline "Shared!"
                      , text """ macro definition): """ ]
               , verbatim """Shared! ← (
  ⊜(⊜⋕⊸≠@-)⊸≠@,
  /+≡(/+▽⊸≡(^0°⋕)⍜-⇡⊙+₁°⊟)
)

Part₁ ← Shared!(≍⊃↙↘⊸(⌊÷₂⧻))"""
               , vspace
               , p [] [ text "Now, onto the actual solution: notice that a number like "
                      , verbatimInline "12341234"
                      , text ", which has eight digits, can be split into: "
                      , verbatimInline "1:2:3:4:1:2:3:4"
                      , text ", "
                      , verbatimInline "12:34:12:34"
                      , text ", "
                      , verbatimInline "1234:1234"
                      , text """ which are splittings of 1, 2 and 4. We notice these are, of
                               course, all divisors of 8 (which are less
                               than 8). And so, we will split into chunks of size """
                      , verbatimInline "d"
                      , text " for each divisor "
                      , verbatimInline "d"
                      , text """ of the length of the current value, and check if all chunks
                          are equal. If any of these checks return true, then the value is invalid."""
                               ]

                      , vspace
                      , p [] [text """First, we need a list of divisors of
                                    the length. We'll use a very simple approach: we'll get
                                    all numbers under the length and we'll find the indices
                                    of the values that are equal to zero, modulo the length:"""]
                      , verbatim "⊚=₀◿⊸⇡⧻"
                      , vspace

                      , p [] [ text "We'll now split into chunks of size "
                             , verbatimInline "d"
                             , text ". Given we have "
                             , verbatimInline "d"
                             , text " and the original number ready, we can use "
                             , primitive "stencil" "⧈"
                             , text "'s chunking behaviour (with the double "
                             , primitive "fix" "¤"
                             , text """) to get the chunks easily.  After we've got the
                                 chunks, we can use one of the many 'all equal' idioms, like """
                             , verbatimInline "=₁⧻◴"
                             , text " or "
                             , verbatimInline "≍⊸↻₁"
                             , text "."]
                      , p [] [text """Put together, we can check if the divisor leads
                                    to chunks that are all equal with"""]
                      , verbatim """=₁⧻◴⧈∘¤¤"""
                      , p [] [ text """We finish up the code by running through all divisors using """
                             , verbatimInline "≡⌟"
                             , text " and checking if any of these succeeded using "
                             , verbatimInline "/∨"
                             , text "."]
                      , vspace
                      , p [] [ text "And so, we arrive at our final invalidness check for Part 2:"]
                      , verbatim """/∨≡⌟(=₁⧻◴⧈∘¤¤)⊸(=₁⧻◴)"""
               ] 




    
bothPartsEmbedLink : String
bothPartsEmbedLink = "https://uiua.org/embed?src=0_18_0-dev_3__eJxVkEFLwzAcxe_5FBl6aFnCmjRpk4PgxbuwuzBwoKAiw4NHV2Gu0YGXuU0GszCYxx0EB0OE-k3eJ5G2K2gS8n4J7__PI3v06Pa62zu_7F7ddC4aZJ8KwaVkVnMhNLPWcBEIyYQwRhdbwGu0AZPFCHgpionIGi0lr9QwpSKlQl6KZaHRNjQ64hVEkulIRzrkpVhmpCqX4DXFTIpqCsNrlIq0O5fXF12KwTMh7bNOr3vaKA7UI5TCzT24OR7HcBukb4fc3wEjlLaaSDOv1cTLV3mbeSdBvsbj2MdozvGQwc2aSPr5Gm7hE5-Q407vBkm_7L97y0M6grvHYIbBFG7j4cn9fCJJsNr6_q4i-VfRwvAdaYanhXeApI_VFpMPrIYYTvNlviwienCvB0juMPkuoj1kVTeC0RLLGdIRFVLGcay1VrROVf3EH48SsQpjKyO98yS15xclg7y9"
