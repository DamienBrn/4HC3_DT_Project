module HomePageCss exposing (..)

import Css exposing (..)
import Css.Media exposing (withMediaQuery)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick, onInput)

-- css file for homepage elements

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
          backgroundColor (rgb 250 154 42),
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
          marginTop (px 150)
     ]

additionPageButtonContainer =
     [
          width (rem 32),
          margin auto,
          backgroundColor (rgb 217 217 217),
          padding (px 20),
          borderRadius (px 15),
          color (rgb 116 102 101),
          verticalAlign middle
     ]

pageButtonImg = 
     [
          marginRight (px 40),
          width (px 40),
          display inlineBlock
     ]

pageButtonText = 
     [
          fontSize (px 35),
          marginRight (px 15),
          display inlineBlock,
          verticalAlign top,
          width (px 201)
     ]

pageButtonLink =
     [
          display inlineBlock,
          backgroundColor (rgb 255 102 61),
          color (rgb 255 255 255),
          width (px 150),
          textAlign center,
          verticalAlign top,
          padding (px 4),
          borderRadius (px 5),
          marginLeft (px 30),
          textDecoration none
     ]

multiplicationButtonContainer =
     [
          width (rem 32),
          margin auto,
          backgroundColor (rgb 217 217 217),
          padding (px 20),
          borderRadius (px 15),
          color (rgb 116 102 101),
          verticalAlign middle,
          marginTop (px 100)
     ]
