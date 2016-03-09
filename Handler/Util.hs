module Handler.Util where

import Import
import Data.List (init)

navPages :: [Route App]
navPages = [ HomeR, PhilosophyR ]

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
  $(widgetFile "sidebar")
  addScript $ StaticR js_bootstrap_min_js
