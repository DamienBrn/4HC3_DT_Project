module Multiplication exposing (..)

import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick, onInput)

-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view >> toUnstyled }



-- MODEL


type alias Model = { 
     answ1 : String, 
     answ2 : String, 
     answ3 : String,
     a1ValidatedCode : Int,
     a2ValidatedCode : Int,
     a3ValidatedCode : Int }


init : Model
init =
  {
       answ1 = "-999",
       answ2 = "-999",
       answ3 = "-999",
       a1ValidatedCode = 0,
       a2ValidatedCode = 0,
       a3ValidatedCode = 0
  }



-- UPDATE


type Msg
  = ModifyAnsw1 String
  | ModifyAnsw2 String
  | ModifyAnsw3 String
  | UpdateValidatedCode Int Int Int


update : Msg -> Model -> Model
update msg model =
  case msg of
     ModifyAnsw1 val ->
          { model | answ1 = val }
     ModifyAnsw2 val ->
          { model | answ2 = val }
     ModifyAnsw3 val ->
          { model | answ3 = val }
     UpdateValidatedCode c1 c2 c3 ->
          { model | a1ValidatedCode = c1, a2ValidatedCode = c2, a3ValidatedCode = c3 }



-- Support Functions
getA1ValidatedCode model =
     if model.answ1 == "6" then
          1
     else if model.answ1 == "" then
          0
     else
          2

getA2ValidatedCode model =
     if model.answ2 == "4" then
          1
     else if model.answ2 == "" then
          0
     else
          2

getA3ValidatedCode model =
     if model.answ3 == "20" then
          1
     else if model.answ3 == "" then
          0
     else
          2

validateAnsws model =
     let
          a1ValidatedCode = getA1ValidatedCode model
          a2ValidatedCode = getA2ValidatedCode model
          a3ValidatedCode = getA3ValidatedCode model
     in
          UpdateValidatedCode a1ValidatedCode a2ValidatedCode a3ValidatedCode

getValidateImg validator =
     if validator == 1 then
          "assest/success.png"
     else if validator == 0 then
          ""
     else
          "assest/error.png"

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
               img [ src "assest/multiplication.png", css sectionSpliterIconStyle ] [],
               div [ css sectionSpliterTextContainerStyle ] [text "Multiplications"]
          ],
          -- main addition section
          div [ css mainSectionStyle ] [
               -- title
               div [ css mainSectionTitleStyle ] [text "Type your answer into the box next to each multiplication"],
               -- addition part 1
               div [ css mainSectionAdditionContainerStyle ] [
                    span [] [text "1 * 6 = "],
                    input [ onInput ModifyAnsw1 ] [],
                    img [ css mainSectionAdditionFB, getValidateImg model.a1ValidatedCode |> src ] []
               ],
               -- addition part 2
               div [ css mainSectionAdditionContainerStyle ] [
                    span [] [text "2 * 2 = "],
                    input [ onInput ModifyAnsw2 ] [],
                    img [ css mainSectionAdditionFB, getValidateImg model.a2ValidatedCode |> src ] []
               ],
               -- addition part 3
               div [ css mainSectionAdditionContainerStyle ] [
                    span [] [text "5 * 4 = "],
                    input [ onInput ModifyAnsw3 ] [],
                    img [ css mainSectionAdditionFB, getValidateImg model.a3ValidatedCode |> src ] []
               ],
               -- click to verify button
               div [ css mainSectionVerifyButtonContainerStyle ] [
                    button [ css mainSectionVerifyButtonStyle, onClick (validateAnsws model) ] [
                         div [] [
                              div [ css verifyButtonTextContainerStyle ] [ text "Click here to verify if your answers are correct" ],
                              img [ src "assest/check.png", css verifyButtonCheckIconStyle ] []
                         ]
                    ]
               ],
               -- number of exercies
               div [ css mainSectionNumberOfExeContainerStyle ] [
                    span [] [text "Exerciese 2/2"]
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
                         img [ src "assest/left-arrow.png", css goToNextSectionButtonCheckIconStyle ] [],
                         div [ css goToNextSectionContainerStyle ] [ text "Go to next exercies" ]
                    ]
               ]
          ]
     ]

-- CSS

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
          backgroundColor (rgb 112 152 249),
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
          backgroundColor (rgb 112 152 249),
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
          left (px 50),
          top (px 250)
     ]

goToNextSectionContainerStyle = 
     [
          display inlineBlock,
          marginLeft (px 5),
          height (px 18)
     ]

goToNextSectionButtonCheckIconStyle = 
     [
          width (px 18),
          height (px 18),
          display inlineBlock,
          verticalAlign top,
          marginRight (px 5)
     ]

mainSectionAdditionFB = 
     [
          position absolute,
          marginLeft (px 5),
          width (px 30)
     ]