module Addition exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
-- import Html exposing (Html, button, div, text, span, input)
-- import Html.Events exposing (onClick)
-- import Html.Styled exposing (..)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)

-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view >> toUnstyled }



-- MODEL


type alias Model = Int


init : Model
init =
  0



-- UPDATE


type Msg
  = Increment
  | Decrement


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1



-- VIEW


view : Model -> Html Msg
view model =
  div []
     [
          -- header
          div [ css headerStyle ] [
               div[] [text "4HC3-Alternative Project(G5)"],
               -- image
               div[] []
          ],
          -- section spliter
          div [ css sectionSpliterStyle ] [
               -- addition icon
               -- div [ css sectionSpliterIconContainerStyle ] [
               --      img [ src "assest/addition.png", css sectionSpliterIconStyle ] []
               -- ],
               img [ src "assest/addition.png", css sectionSpliterIconStyle ] [],
               div [ css sectionSpliterTextContainerStyle ] [text "Additions"]
          ],
          -- main addition section
          div [ css mainSectionStyle ] [
               -- title
               div [ css mainSectionTitleStyle ] [text "Type your answer into box next to each addition"],
               -- addition part 1
               div [ css mainSectionAdditionContainerStyle ] [
                    span [] [text "3 + 1 = "],
                    input [] []
               ],
               -- addition part 2
               div [ css mainSectionAdditionContainerStyle ] [
                    span [] [text "6 + 5 = "],
                    input [] []
               ],
               -- addition part 3
               div [ css mainSectionAdditionContainerStyle ] [
                    span [] [text "9 + 8 = "],
                    input [] []
               ],
               -- click to verify button
               div [ css mainSectionVerifyButtonContainerStyle ] [
                    button [css mainSectionVerifyButtonStyle] [
                         div [] [
                              div [ css verifyButtonTextContainerStyle ] [ text "Click here to verify if your answers are correct" ],
                              img [ src "assest/check.png", css verifyButtonCheckIconStyle ] []
                         ]
                    ]
               ],
               -- number of exercies
               div [ css mainSectionNumberOfExeContainerStyle ] [
                    span [] [text "Exerciese 1/2"]
               ],
               -- go to home page button
               div [ css mainSectionGoToHomeButtonContainerStyle ] [
                    button [ css mainSectionGoToHomeButtonStyle ] [
                              div [] [
                                   div [ css goToHomeButtonTextContainerStyle ] [ text "Go to Homepage" ],
                                   img [ src "assest/home.png", css goToHomeButtonCheckIconStyle ] []
                              ]
                         ]
               ],
               -- go to next exercies button
               button [ css mainSectionGoToNextExerciseButtonStyle ] [
                    div [] [
                         div [ css goToNextSectionContainerStyle ] [ text "Go to next exercies" ],
                         img [ src "assest/right-arrow.png", css goToNextSectionButtonCheckIconStyle ] []
                    ]
               ]
          ]
     ]

headerStyle = 
     [
          height (pct 10),
          padding (px 25),
          fontSize (px 30),
          textAlign center
     ]

sectionSpliterStyle =
     [
          textAlign center,
          fontSize (px 30),
          backgroundColor (rgb 252 0 249),
          padding (px 20),
          color (rgb 255 255 255)
     ]

sectionSpliterIconStyle = 
     [
          width (px 30),
          height (px 30),
          display inlineBlock,
          verticalAlign top,
          marginRight (px 5)
     ]

sectionSpliterTextContainerStyle = 
     [
          display inlineBlock,
          height (px 30)
     ]


mainSectionStyle = 
     [
          marginTop (px 25)
     ]

mainSectionTitleStyle = 
     [
          fontSize (px 20),
          textAlign center
     ]

mainSectionAdditionContainerStyle = 
     [
          fontSize (px 25),
          margin (px 10),
          textAlign center
     ]

mainSectionVerifyButtonContainerStyle = 
     [
          textAlign center
     ]

mainSectionVerifyButtonStyle = 
     [
          fontSize (px 15),
          border (px 0),
          backgroundColor (rgb 252 0 249),
          padding (px 15),
          borderRadius (px 10),
          color (rgb 255 255 255)
     ]

verifyButtonTextContainerStyle = 
     [
          display inlineBlock,
          marginRight (px 5),
          height (px 18)
     ]

verifyButtonCheckIconStyle = 
     [
          width (px 18),
          height (px 18),
          display inlineBlock,
          verticalAlign top,
          marginLeft (px 5)
     ]

mainSectionNumberOfExeContainerStyle = 
     [
          fontSize (px 20),
          textAlign center,
          marginTop (px 30)
     ]

mainSectionGoToHomeButtonContainerStyle = 
     [
          textAlign center
     ]

mainSectionGoToHomeButtonStyle = 
     [
          fontSize (px 15),
          border (px 0),
          backgroundColor (rgb 250 154 43),
          padding (px 15),
          borderRadius (px 10),
          color (rgb 255 255 255)
     ]

goToHomeButtonTextContainerStyle = 
     [
          display inlineBlock,
          marginRight (px 5),
          height (px 18)
     ]

goToHomeButtonCheckIconStyle = 
     [
          width (px 18),
          height (px 18),
          display inlineBlock,
          verticalAlign top,
          marginLeft (px 5)
     ]

mainSectionGoToNextExerciseButtonStyle = 
     [
          fontSize (px 15),
          border (px 0),
          backgroundColor (rgb 105 152 40),
          padding (px 15),
          borderRadius (px 10),
          marginTop (px 15),
          color (rgb 255 255 255),
          position fixed,
          right (px 50),
          top (px 250)
     ]

goToNextSectionContainerStyle = 
     [
          display inlineBlock,
          marginRight (px 5),
          height (px 18)
     ]

goToNextSectionButtonCheckIconStyle = 
     [
          width (px 18),
          height (px 18),
          display inlineBlock,
          verticalAlign top,
          marginLeft (px 5)
     ]