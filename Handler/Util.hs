module Handler.Util where

import Import
import CssUtil
import Data.List (init)
import Text.Julius (RawJS (..))

withSidebar :: Route App -> Widget -> Widget
withSidebar route content = do
  [whamlet|
    <div.row>
      <div.col-md-2.col-sidebar>
        ^{sidebarWidget route}

      <div.col-md-10>
        ^{content}
  |]

sidebarWidget :: Route App -> Widget
sidebarWidget currRoute = do
  let pages = map (\ route -> (route, route == currRoute)) navPages
  sidebarId <- newIdent
  $(widgetFile "sidebar")
  addScript $ StaticR js_util_js
  addStylesheet $ StaticR css_util_css
