module CssUtil where

import Data.Text
import Text.Lucius

colorPrimary :: Text
colorPrimary = "hsl(0, 0%, 20%)"

colorAccent :: Text
colorAccent = "hsl(120, 60%, 40%)"

colorAccentDark :: Text
colorAccentDark = "hsl(120, 60%, 30%)"

platformPrefixes :: Text -> Text -> Mixin
platformPrefixes prop val =[luciusMixin|
  -webkit-#{prop}: #{val};
  -moz-#{prop}: #{val};
  -ms-#{prop}: #{val};
  -o-#{prop}: #{val};
  #{prop}: #{val};
|]
