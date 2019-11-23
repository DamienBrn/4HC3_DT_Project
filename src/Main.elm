module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)

import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid


view model =
    div [ class "jumbotron" ]
        [ h1 [] [ text "4HC3 FALL 2019" ]
        , p []
            [ text "test "
             
            ]
        ]


main =
    view "dummy model"
