module Handler.Curator where

import Import
import Model.User

getCuratorR :: UserId -> Handler Html
getCuratorR i = do
  u <- runDBor404 $ get i
  defaultLayout $ do
    setTitle' $ uname u
    [whamlet|
<div .ui.container>
  <h1>#{uname u}
|]

uname :: User -> Text
uname = fromMaybe "Anonymous" . userName

getCuratorsR :: Handler Value
getCuratorsR = do
  curators <- runDB $ getUsersWithRole Curator
  return $ object ["curators" .= curators]
