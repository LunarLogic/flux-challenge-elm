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
--
-- The final algorithm should look more or less like this:
--
-- (add)
-- 1. If the roster is empty, put the sith in the middle and go to point 4.
-- 2. If it's not empty, then look for Loading value with the ID of the given Sith.
-- 3. Replace (Loading id) with (Occupied sith).
-- 4. If places in the roster above and below that sith are Empty, replace them with Reserved and
--    the appropriate IDs of a master and an apprentice.
-- (determineNextSithToFetch)
-- 5. Check if the roster includes any (Loading id) values. If it does, then return (roster,
--    Nothing).
-- 6. If it doesn't, find the first (Reserved id) value in reverse order, replace it with (Loading
--    id) and return that ID in the tuple (roster, Just id).


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


reserveNeighbourSith : Int -> Int -> Roster -> Roster
reserveNeighbourSith index id roster =
    case Array.get index roster of
        Just Empty ->
            Array.set index (Reserved id) roster

        _ ->
            roster


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
