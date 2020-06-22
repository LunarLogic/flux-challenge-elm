module Roster exposing (Cell(..), Roster, Sith, add, determineNextSithToFetch, empty)

-- https://package.elm-lang.org/packages/elm/core/latest/Array

import Array exposing (Array)


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
    , masterId : Int
    , apprenticeId : Int
    }


empty : Roster
empty =
    Array.repeat 5 Empty



-- For now handle only the case where the roster is empty and we're adding
-- the first sith in the middle.


add : Sith -> Roster -> Roster
add sith roster =
    if roster == empty then
        roster
            |> Array.set 2 (Occupied sith)
            |> Array.set 1 (Reserved sith.masterId)
            |> Array.set 3 (Reserved sith.apprenticeId)

    else
        roster


determineNextSithToFetch : Roster -> ( Roster, Maybe Int )
determineNextSithToFetch roster =
    -- roster
    --     |> Array.set 3 (Loading Array.get 3 roster)
    let
        nextSith =
            Array.get 3 roster
    in
    case nextSith of
        Reserved sithId ->
            Array.set 3 (Loading sithId) roster
