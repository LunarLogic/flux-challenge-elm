module Array.Helpers exposing (indexOf)

import Array exposing (Array)
import List.Extra


indexOf : a -> Array a -> Maybe Int
indexOf target array =
    array
        |> Array.toList
        |> List.Extra.elemIndex target
