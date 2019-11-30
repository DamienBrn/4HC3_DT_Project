module MultiplicationCss exposing (..)

import Css exposing (..)
import Css.Media exposing (withMediaQuery)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick, onInput)

linkStyle = 
     [
          color (rgb 255 255 255)
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
          [right (px 500), fontSize (px 25)]
     ]