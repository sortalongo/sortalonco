module Handler.Simple where

import Import
import Handler.Util

getCareerR :: Handler Html
getCareerR = defaultLayout . withSidebar CareerR $ do
  setTitle "Career"
  $(widgetFile "career")

getMetaR :: Handler Html
getMetaR = defaultLayout . withSidebar MetaR $ do
  setTitle "Meta"
  $(widgetFile "meta")

getPhilosophyR :: Handler Html
getPhilosophyR = defaultLayout . withSidebar PhilosophyR $ do
  setTitle "Philosophy"
  $(widgetFile "philosophy")
  addStylesheet $ StaticR css_util_css
