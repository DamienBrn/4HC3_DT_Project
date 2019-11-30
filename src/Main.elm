module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Css exposing (..)
import Css.Media exposing (withMediaQuery)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick, onInput)
import Url

import HomePageCss exposing(..)
import AdditionCss exposing(..)
import MultiplicationCss exposing(..)

-- MAIN

main =
  Browser.application
    { init = init
    , view = view >> toUnstyledDocument
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }

-- TYPE

type Pages
    = Homepage
    | Addition
    | Multiplication

-- MODEL

type alias Model = 
    { page: Pages
    , selectedAnsw : Int
    , answ1 : String
    , answ2 : String 
    , answ3 : String
    , a1ValidatedCode : Int
    , a2ValidatedCode : Int
    , a3ValidatedCode : Int
    , key: Nav.Key
    , url: Url.Url 
    }

-- INIT

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model Homepage 0 "" "" "" 0 0 0 key url, Cmd.none )

-- UPDATE

type Msg
  = ModifyAnsw1 String
  | ModifyAnsw2 String
  | ModifyAnsw3 String
  | UpdateValidatedCode Int Int Int
  | UpdateSelectedInput Int
  | UrlChanged Url.Url
  | LinkClicked Browser.UrlRequest
  | DoNothing

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
     LinkClicked urlRequest ->
          case urlRequest of
                Browser.Internal url ->
                    if (String.contains "addition" (Url.toString url)) then
                        (
                            {model 
                            | page = Addition
                            , selectedAnsw = 0
                            , answ1 = ""
                            , answ2 = ""
                            , answ3 = ""
                            , a1ValidatedCode = 0
                            , a2ValidatedCode = 0
                            , a3ValidatedCode = 0
                            }, 
                            Nav.pushUrl model.key (Url.toString url)
                        )
                    else if (String.contains "multiplication" (Url.toString url)) then
                        (
                            {model 
                            | page = Multiplication
                            , selectedAnsw = 0
                            , answ1 = ""
                            , answ2 = ""
                            , answ3 = ""
                            , a1ValidatedCode = 0
                            , a2ValidatedCode = 0
                            , a3ValidatedCode = 0
                            }, 
                            Nav.pushUrl model.key (Url.toString url)
                        )
                    else
                        (
                            {model 
                            | page = Homepage
                            , selectedAnsw = 0
                            , answ1 = ""
                            , answ2 = ""
                            , answ3 = ""
                            , a1ValidatedCode = 0
                            , a2ValidatedCode = 0
                            , a3ValidatedCode = 0
                            }, 
                            Nav.pushUrl model.key (Url.toString url)
                        )
                Browser.External href ->
                    ( model, Nav.load href )
     UrlChanged url ->
          ({ model | url = url }, Cmd.none)
     ModifyAnsw1 val ->
          ({ model | answ1 = val }, Cmd.none)
     ModifyAnsw2 val ->
          ({ model | answ2 = val }, Cmd.none)
     ModifyAnsw3 val ->
          ({ model | answ3 = val }, Cmd.none)
     UpdateValidatedCode c1 c2 c3 ->
          ({ model | a1ValidatedCode = c1, a2ValidatedCode = c2, a3ValidatedCode = c3 }, Cmd.none)
     UpdateSelectedInput numb ->
          ({ model | selectedAnsw = numb }, Cmd.none)
     DoNothing ->
          (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


-- Support Functions

getA1ValidatedCode model =
    case model.page of
        Addition ->
            if model.answ1 == "4" then
                1
            else if model.answ1 == "" then
                0
            else
                2
        Multiplication ->
            if model.answ1 == "6" then
                1
            else if model.answ1 == "" then
                0
            else
                2
        _ ->
            0

getA2ValidatedCode model =
    case model.page of
        Addition ->
            if model.answ2 == "11" then
                1
            else if model.answ2 == "" then
                0
            else
                2
        Multiplication ->
            if model.answ2 == "4" then
                1
            else if model.answ2 == "" then
                0
            else
                2
        _ ->
            0

getA3ValidatedCode model =
    case model.page of
        Addition ->
            if model.answ3 == "17" then
                1
            else if model.answ3 == "" then
                0
            else
                2
        Multiplication ->
            if model.answ3 == "20" then
                1
            else if model.answ3 == "" then
                0
            else
                2
        _ ->
            0

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
    case model.page of
        Addition ->        
            if inputNumb == model.selectedAnsw then
                [ backgroundColor (rgb 46 204 113) ]
            else
                [ backgroundColor (rgb 252 0 249) ]
        Multiplication ->
            if inputNumb == model.selectedAnsw then
                [ backgroundColor (rgb 46 204 113) ]
            else
                [ backgroundColor (rgb 112 152 249) ]
        _ ->
            [ backgroundColor (rgb 46 204 113) ]

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

toUnstyledDocument doc =
    { title = doc.title
    , body = List.map toUnstyled doc.body
    }

view model =
  { title = "4HC3 G5 Project"
  , body = (getRenderElement model)
  }

getRenderElement model =
    case model.page of 
        Addition ->
            additionPageElements model
        Multiplication ->
            multiplicationPageElements model
        _ ->
            homePageElements model

-- ELEMENTS

homePageElements model = 
    [
        div [] [
            -- header
            div [ css HomePageCss.headerStyle ] [
                div[] [text "4HC3-Alternative Project(G5)"],
                -- image
                div[] []
            ],
            -- section spliter
            div [ css HomePageCss.sectionSpliterStyle ] [
                img [ src "assest/home.png", css HomePageCss.sectionSpliterIconStyle ] [],
                div [ css HomePageCss.sectionSpliterTextContainerStyle ] [text "Homepage"]
            ],
               -- main addition section
            div [ css HomePageCss.mainSectionStyle ] [
                -- go to addition
                div [ css HomePageCss.additionPageButtonContainer] [
                    img [ src "assest/addition-colored.png", css HomePageCss.pageButtonImg ] [],
                    div [ css HomePageCss.pageButtonText ] [ text "Additions" ],
                    a [ css pageButtonLink, href "/addition" ] [text "Click here to start the exercise"]
                ],
                div [ css HomePageCss.multiplicationButtonContainer, css [ marginTop (px 100)] ] [
                    img [ src "assest/multiplication-colored.png", css HomePageCss.pageButtonImg ] [],
                    div [ css HomePageCss.pageButtonText ] [ text "Multiplication" ],
                    a [ css pageButtonLink, href "/multiplication" ] [text "Click here to start the exercise"]
                ]
                
            ]
        ]
    ]

additionPageElements model = 
     [
          div [] [
               -- header
               div [ css AdditionCss.headerStyle ] [
                    div[] [text "4HC3-Alternative Project(G5)"],
                    -- image
                    div[] []
               ],
               -- section spliter
               div [ css AdditionCss.sectionSpliterStyle ] [
                    img [ src "assest/addition.png", css AdditionCss.sectionSpliterIconStyle ] [],
                    div [ css AdditionCss.sectionSpliterTextContainerStyle ] [text "Additions"]
               ],
               -- main addition section
               div [ css AdditionCss.mainSectionStyle ] [
                    -- boy
                    div [] [
                         img [src "assest/character.png", css AdditionCss.character, css AdditionCss.characterLargeWidth] [],
                         div [css AdditionCss.characterBubble, css AdditionCss.characterBubbleLargeWidth] [text "Type your answer into the box next to each addition"]
                    ],
                    -- addition part 1
                    div [ css AdditionCss.mainSectionAdditionContainerStyle ] [
                         div [ css AdditionCss.mainSectionQuestionText ] [text "3 + 1 = "],
                         div [ css AdditionCss.mainSectionInputContainer, (isInputSelected 1 model) |> css, onClick (UpdateSelectedInput 1) ] [ text model.answ1 ],
                         img [ css AdditionCss.mainSectionAdditionFB, getValidateImg model.a1ValidatedCode |> src ] []
                    ],
                    -- addition part 2
                    div [ css AdditionCss.mainSectionAdditionContainerStyle ] [
                         div [ css AdditionCss.mainSectionQuestionText ] [text "6 + 5 = "],
                         div [ css AdditionCss.mainSectionInputContainer, (isInputSelected 2 model) |> css, onClick (UpdateSelectedInput 2) ] [ text model.answ2 ],
                         img [ css AdditionCss.mainSectionAdditionFB, getValidateImg model.a2ValidatedCode |> src ] []
                    ],
                    -- addition part 3
                    div [ css AdditionCss.mainSectionAdditionContainerStyle ] [
                         div [ css AdditionCss.mainSectionQuestionText ] [text "9 + 8 = "],
                         div [ css AdditionCss.mainSectionInputContainer, (isInputSelected 3 model) |> css, onClick (UpdateSelectedInput 3) ] [ text model.answ3 ],
                         img [ css AdditionCss.mainSectionAdditionFB, getValidateImg model.a3ValidatedCode |> src ] []
                    ],
                    div [ css AdditionCss.osKeyboardBtnContainer ] [
                         div [ css AdditionCss.osKeyboardBtnInstruction ] [ text "Input number by pressing buttons below"],
                         ul [] [
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "0" model) ] [ text "0" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "1" model) ] [ text "1" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "2" model) ] [ text "2" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "3" model) ] [ text "3" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "4" model) ] [ text "4" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "5" model) ] [ text "5" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "6" model) ] [ text "6" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "7" model) ] [ text "7" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "8" model) ] [ text "8" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "9" model) ] [ text "9" ],
                              li [ css AdditionCss.osKeyboardBtn, onClick (inputSelectedVal "del" model) ] [ text "←" ]
                         ]
                    ],
                    -- click to verify button
                    div [ css AdditionCss.mainSectionVerifyButtonContainerStyle ] [
                         button [ css AdditionCss.mainSectionVerifyButtonStyle, onClick (validateAnsws model) ] [
                              div [] [
                                   div [ css AdditionCss.verifyButtonTextContainerStyle ] [ text "Click here to verify if your answers are correct" ],
                                   img [ src "assest/check.png", css AdditionCss.verifyButtonCheckIconStyle ] []
                              ]
                         ]
                    ],
                    -- number of exercies
                    div [ css AdditionCss.mainSectionNumberOfExeContainerStyle ] [
                         span [] [text "Exerciese 1/2"]
                    ],
                    -- go to home page button
                    div [ css AdditionCss.mainSectionGoToHomeButtonContainerStyle ] [
                         button [ css AdditionCss.mainSectionGoToHomeButtonStyle ] [
                                   div [] [
                                        a [ href "/", css AdditionCss.linkStyle ] [
                                            div [ css AdditionCss.goToHomeButtonTextContainerStyle ] [ text "Go to Homepage" ],
                                            img [ src "assest/home.png", css AdditionCss.goToHomeButtonCheckIconStyle ] []
                                        ]
                                   ]
                              ]
                    ],
                    -- go to next exercies button
                    button [ css AdditionCss.mainSectionGoToNextExerciseButtonStyle ] [
                         div [] [
                            a [ href "/multiplication", css AdditionCss.linkStyle ] [
                                div [ css AdditionCss.goToNextSectionContainerStyle ] [ text "Go to next exercies" ],
                                img [ src "assest/right-arrow.png", css AdditionCss.goToNextSectionButtonCheckIconStyle ] []
                            ]
                         ]
                    ]
               ]
          ]
     ]

multiplicationPageElements model = 
     [
          div [] [
               -- header
               div [ css MultiplicationCss.headerStyle ] [
                    div[] [text "4HC3-Alternative Project(G5)"],
                    -- image
                    div[] []
               ],
               -- section spliter
               div [ css MultiplicationCss.sectionSpliterStyle ] [
                    img [ src "assest/multiplication.png", css MultiplicationCss.sectionSpliterIconStyle ] [],
                    div [ css MultiplicationCss.sectionSpliterTextContainerStyle ] [text "Multiplications"]
               ],
               -- main addition section
               div [ css MultiplicationCss.mainSectionStyle ] [
                    -- boy
                    div [] [
                         img [src "assest/character.png", css MultiplicationCss.character, css MultiplicationCss.characterLargeWidth] [],
                         div [css MultiplicationCss.characterBubbleLargeWidth, css MultiplicationCss.characterBubble] [text "Type your answer into the box next to each multiplication"]
                    ],
                    -- addition part 1
                    div [ css MultiplicationCss.mainSectionAdditionContainerStyle ] [
                         div [ css MultiplicationCss.mainSectionQuestionText ] [text "1 * 6 = "],
                         div [ css MultiplicationCss.mainSectionInputContainer, (isInputSelected 1 model) |> css, onClick (UpdateSelectedInput 1) ] [ text model.answ1 ],
                         img [ css MultiplicationCss.mainSectionAdditionFB, getValidateImg model.a1ValidatedCode |> src ] []
                    ],
                    -- addition part 2
                    div [ css MultiplicationCss.mainSectionAdditionContainerStyle ] [
                         div [ css MultiplicationCss.mainSectionQuestionText ] [text "2 * 2 = "],
                         div [ css MultiplicationCss.mainSectionInputContainer, (isInputSelected 2 model) |> css, onClick (UpdateSelectedInput 2) ] [ text model.answ2 ],
                         img [ css MultiplicationCss.mainSectionAdditionFB, getValidateImg model.a2ValidatedCode |> src ] []
                    ],
                    -- addition part 3
                    div [ css MultiplicationCss.mainSectionAdditionContainerStyle ] [
                         div [ css MultiplicationCss.mainSectionQuestionText ] [text "5 * 4 = "],
                         div [ css MultiplicationCss.mainSectionInputContainer, (isInputSelected 3 model) |> css, onClick (UpdateSelectedInput 3) ] [ text model.answ3 ],
                         img [ css MultiplicationCss.mainSectionAdditionFB, getValidateImg model.a3ValidatedCode |> src ] []
                    ],
                    div [ css MultiplicationCss.osKeyboardBtnContainer ] [
                         div [ css MultiplicationCss.osKeyboardBtnInstruction ] [ text "Input number by pressing buttons below"],
                         ul [] [
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "0" model) ] [ text "0" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "1" model) ] [ text "1" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "2" model) ] [ text "2" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "3" model) ] [ text "3" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "4" model) ] [ text "4" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "5" model) ] [ text "5" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "6" model) ] [ text "6" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "7" model) ] [ text "7" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "8" model) ] [ text "8" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "9" model) ] [ text "9" ],
                              li [ css MultiplicationCss.osKeyboardBtn, onClick (inputSelectedVal "del" model) ] [ text "←" ]
                         ]
                    ],
                    -- click to verify button
                    div [ css MultiplicationCss.mainSectionVerifyButtonContainerStyle ] [
                         button [ css MultiplicationCss.mainSectionVerifyButtonStyle, onClick (validateAnsws model) ] [
                              div [] [
                                   div [ css MultiplicationCss.verifyButtonTextContainerStyle ] [ text "Click here to verify if your answers are correct" ],
                                   img [ src "assest/check.png", css MultiplicationCss.verifyButtonCheckIconStyle ] []
                              ]
                         ]
                    ],
                    -- number of exercies
                    div [ css MultiplicationCss.mainSectionNumberOfExeContainerStyle ] [
                         span [] [text "Exerciese 2/2"]
                    ],
                    -- go to home page button
                    div [ css MultiplicationCss.mainSectionGoToHomeButtonContainerStyle ] [
                         button [ css MultiplicationCss.mainSectionGoToHomeButtonStyle ] [
                                   div [] [
                                        a [ href "/", css MultiplicationCss.linkStyle ] [
                                            div [ css MultiplicationCss.goToHomeButtonTextContainerStyle ] [ text "Go to Homepage" ],
                                            img [ src "assest/home.png", css MultiplicationCss.goToHomeButtonCheckIconStyle ] []
                                        ]
                                   ]
                              ]
                    ],
                    -- go to next exercies button
                    button [ css MultiplicationCss.mainSectionGoToNextExerciseButtonStyle ] [
                         div [] [
                              a [ href "/addition", css MultiplicationCss.linkStyle ] [
                                   img [ src "assest/left-arrow.png", css MultiplicationCss.goToNextSectionButtonCheckIconStyle ] [],
                                   div [ css MultiplicationCss.goToNextSectionContainerStyle ] [ text "Go to previous exercies" ]
                              ]
                         ]
                    ]
               ]
          ]
     ]