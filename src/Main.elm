module Main exposing (..)

import Array
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as D
import Roster exposing (Cell(..), Roster, Sith)


type alias Model =
    Roster


type Msg
    = SithReceived (Result Http.Error Sith)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }


sithDecoder : D.Decoder Sith
sithDecoder =
    D.map4 Sith
        (D.field "name" D.string)
        (D.field "homeworld" (D.field "name" D.string))
        (D.field "master" (D.field "id" D.int))
        (D.field "apprentice" (D.field "id" D.int))


init : () -> ( Model, Cmd Msg )
init flag =
    ( Roster.empty
    , Http.get
        { url = "http://localhost:3000/dark-jedis/3616"
        , expect = Http.expectJson SithReceived sithDecoder
        }
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SithReceived (Ok sith) ->
            ( Roster.add sith model, Cmd.none )

        SithReceived (Err _) ->
            ( model, Cmd.none )


viewSith : Cell -> Html msg
viewSith cell =
    case cell of
        Occupied sith ->
            li [ class "css-slot" ]
                [ h3 []
                    [ text sith.name ]
                , h6 []
                    [ text <| "Homeworld: " ++ sith.homeworld ]
                ]

        _ ->
            li [ class "css-slot" ] []


view : Model -> Html msg
view roster =
    div [ class "app-container" ]
        [ div [ class "css-root" ]
            [ h1 [ class "css-planet-monitor" ]
                [ text "Obi-Wan currently on Tatooine" ]
            , section [ class "css-scrollable-list" ]
                [ ul [ class "css-slots" ] (Array.map viewSith roster |> Array.toList)
                , div [ class "css-scroll-buttons" ]
                    [ button [ class "css-button-up" ]
                        []
                    , button [ class "css-button-down" ]
                        []
                    ]
                ]
            ]
        ]
