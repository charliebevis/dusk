module Main where

import ClassyPrelude.Yesod hiding (Proxy)
import Data.Proxy
import Elm
import Elm.Export.Persist
import Elm.Export.Persist.BackendKey ()
import Model

mkSpecBody :: ElmType a => a -> [Text]
mkSpecBody a =
  [ toElmTypeSource    a
  , toElmDecoderSource a
  , toElmEncoderSource a
  ]
defImports :: [Text]
defImports =
  [ "import Json.Decode exposing (..)"
  , "import Json.Decode.Pipeline exposing (..)"
  , "import Json.Encode"
  , "import Http"
  , "import String"
  ]

spec :: Spec
spec =
  Spec ["Data", "Gen"] $
       defImports
       ++ mkSpecBody (Proxy :: Proxy (EntId Event))
       ++ mkSpecBody (Proxy :: Proxy (EntId User))

main = specsToDir [spec] "frontend/src"