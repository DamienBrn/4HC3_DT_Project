module Multiplication exposing (..)

import Browser
import Css exposing (..)
import Css.Media exposing (withMediaQuery)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick, onInput)

-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view >> toUnstyled }



-- MODEL


type alias Model = { 
     selectedAnsw : Int,
     answ1 : String, 
     answ2 : String, 
     answ3 : String,
     a1ValidatedCode : Int,
     a2ValidatedCode : Int,
     a3ValidatedCode : Int }


init : Model
init =
  {
       selectedAnsw = 0,
       answ1 = "",
       answ2 = "",
       answ3 = "",
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
  | UpdateSelectedInput Int
  | DoNothing


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
     UpdateSelectedInput numb ->
          { model | selectedAnsw = numb }
     DoNothing ->
          model


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

isInputSelected inputNumb model =
     if inputNumb == model.selectedAnsw then
          [ backgroundColor (rgb 46 204 113) ]
     else
          [ backgroundColor (rgb 112 152 249) ]

handleUpComingVal income existing =
     if income == "del" then
          String.dropRight 1 existing
     else
          existing ++ income

inputSelectedVal val model = 
     if model.selectedAnsw == 1 then
          (handleUpComingVal val model.answ1) |> ModifyAnsw1
     else if model.selectedAnsw == 2 then
          (handleUpComingVal val model.answ2) |> ModifyAnsw2
     else if model.selectedAnsw == 3 then
          (handleUpComingVal val model.answ3) |> ModifyAnsw3
     else
          DoNothing

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
               -- boy
               div [] [
                    img [src "assest/character.png", css character, css characterLargeWidth] [],
                    div [css characterBubble, css characterBubbleLargeWidth] [text "Type your answer into the box next to each addition"]
               ],
               -- addition part 1
               div [ css mainSectionAdditionContainerStyle ] [
                    div [ css mainSectionQuestionText ] [text "1 * 6 = "],
                    div [ css mainSectionInputContainer, (isInputSelected 1 model) |> css, onClick (UpdateSelectedInput 1) ] [ text model.answ1 ],
                    img [ css mainSectionAdditionFB, getValidateImg model.a1ValidatedCode |> src ] []
               ],
               -- addition part 2
               div [ css mainSectionAdditionContainerStyle ] [
                    div [ css mainSectionQuestionText ] [text "2 * 2 = "],
                    div [ css mainSectionInputContainer, (isInputSelected 2 model) |> css, onClick (UpdateSelectedInput 2) ] [ text model.answ2 ],
                    img [ css mainSectionAdditionFB, getValidateImg model.a2ValidatedCode |> src ] []
               ],
               -- addition part 3
               div [ css mainSectionAdditionContainerStyle ] [
                    div [ css mainSectionQuestionText ] [text "5 * 4 = "],
                    div [ css mainSectionInputContainer, (isInputSelected 3 model) |> css, onClick (UpdateSelectedInput 3) ] [ text model.answ3 ],
                    img [ css mainSectionAdditionFB, getValidateImg model.a3ValidatedCode |> src ] []
               ],
               div [ css osKeyboardBtnContainer ] [
                    div [ css osKeyboardBtnInstruction ] [ text "Input number by pressing buttons below"],
                    ul [] [
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "0" model) ] [ text "0" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "1" model) ] [ text "1" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "2" model) ] [ text "2" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "3" model) ] [ text "3" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "4" model) ] [ text "4" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "5" model) ] [ text "5" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "6" model) ] [ text "6" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "7" model) ] [ text "7" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "8" model) ] [ text "8" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "9" model) ] [ text "9" ],
                         li [ css osKeyboardBtn, onClick (inputSelectedVal "del" model) ] [ text "←" ]
                    ]
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
          marginTop (px 200)
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
          marginTop (px 30),
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

osKeyboardBtnContainer =
     [
          textAlign center,
          margin (px 25)
     ]

osKeyboardBtnInstruction =
     [
          fontSize (px 20),
          margin auto
     ]

osKeyboardBtn = 
     [
          display inlineBlock,
          padding (px 15),
          fontSize (px 30),
          color (rgb 255 255 255),
          backgroundColor (rgb 112 152 249),
          margin (px 5),
          borderRadius (px 5),
          cursor pointer
     ]

mainSectionInputContainer =
     [
          display inlineBlock,
          width (px 200),
          height (px 35),
          borderRadius (px 10),
          color (rgb 255 255 255),
          cursor pointer
     ]

mainSectionQuestionText =
     [
          display inlineBlock,
          height (px 35),
          marginRight (px 10),
          verticalAlign top
     ]

character = 
     [
          position absolute,
          width (rem 12),
          right (rem 5),
          top (rem 15),
          transform (rotateY (deg 180))
     ]

characterLargeWidth =
     [ withMediaQuery ["screen and (min-width: 1500px)"]
          [right (rem 18)]
     ]

characterBubble = 
     [
          position absolute,
          top (rem 15),
          right (rem 17),
          padding (px 20),
          backgroundColor (rgb 217 217 217),
          fontSize (px 20)
     ]

characterBubbleLargeWidth =
     [ withMediaQuery ["screen and (min-width: 1500px)"]
          [right (rem 30), fontSize (px 25)]
     ]