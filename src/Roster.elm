module Roster exposing (Cell(..), Roster, Sith, add, empty)

-- https://package.elm-lang.org/packages/elm/core/latest/Array

import Array exposing (Array)
import Array.Helpers


type alias Roster =
    Array Cell


type alias Id =
    Int


type Cell
    = Empty
    | Occupied Sith
    | Loading Id
    | Reserved Id


type alias Sith =
    { name : String
    , homeworld : String
    , id : Int
    , masterId : Int
    , apprenticeId : Int
    }


empty : Roster
empty =
    Array.repeat 5 Empty



-- For now handle only the case where the roster is empty and we're adding
-- the first sith in the middle.


add : Sith -> Roster -> ( Roster, Maybe Int )
add sith roster =
    if roster == empty then
        roster
            |> Array.set 2 (Occupied sith)
            |> Array.set 1 (Reserved sith.masterId)
            |> Array.set 3 (Reserved sith.apprenticeId)
            |> determineNextSithToFetch

    else
        let
            indexOfLoadingSith =
                Array.Helpers.indexOf (Loading sith.id) roster
        in
        case indexOfLoadingSith of
            Nothing ->
                ( roster, Nothing )

            Just index ->
                Array.set index (Occupied sith) roster
                    |> determineNextSithToFetch


determineNextSithToFetch : Roster -> ( Roster, Maybe Int )
determineNextSithToFetch roster =
    let
        nextSith =
            Array.get 3 roster
    in
    case nextSith of
        Just (Reserved sithId) ->
            ( Array.set 3 (Loading sithId) roster, Just sithId )

        _ ->
            ( roster, Nothing )
