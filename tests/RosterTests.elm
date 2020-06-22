module RosterTests exposing (..)

import Array
import Expect exposing (Expectation)
import Roster exposing (..)
import Test exposing (..)



-- https://excalidraw.com/#json=5749351477411840,g3-DSSqG00HBww_c30qehQ
-- https://flux-challenge-dark-jedis.glitch.me/dark-jedis/3616


addTests : Test
addTests =
    describe "add"
        [ test "places the first sith in the middle of an empty roster" <|
            \_ ->
                let
                    sith =
                        { name = "Darth Sidious"
                        , homeworld = "Lorem Ipsum"
                        , masterId = 1234
                        , apprenticeId = 5678
                        }

                    expectedRoster =
                        Array.fromList
                            [ Empty
                            , Reserved 1234
                            , Occupied sith
                            , Reserved 5678
                            , Empty
                            ]
                in
                Roster.empty
                    |> Roster.add sith
                    |> Expect.equal expectedRoster
        ]
