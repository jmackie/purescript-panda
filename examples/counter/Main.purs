module Main (main) where

import Prelude
import Control.Plus (empty)
import Data.Algebra.Array as A
import Data.Maybe (Maybe(..))
import Effect (Effect)
import FRP.Event as FRP
--
import Panda as P
import Panda.HTML as PH
import Panda.Property as PP

main :: Effect Unit
main = do
  _ <- P.runApplicationInBody application
  pure unit

data Input
  = UpdateCount Int

data Message
  = UserClickedCount
  | UserClickedReset

type State
  = Int

application :: forall output. P.Component Input output Message State
application =
  { initial
  , update
  , view
  , subscription
  }

initial :: { input :: Input, state :: State }
initial =
  { input: UpdateCount 0
  , state: 0
  }

update :: forall output. P.Updater Input output Message State
update _emit dispatch { message } = do
  case message of
    UserClickedCount ->
      dispatch \currentState ->
        { input: Just $ UpdateCount (currentState + 1)
        , state: currentState + 1
        }
    UserClickedReset ->
      dispatch \_ ->
        { input: Just (UpdateCount 0)
        , state: 0
        }

view :: PH.HTML Input Message State
view =
  PH.div_
    [ PH.button'
        [ PP.onClick \_mouseEvent -> Just UserClickedCount
        ] \{ input } -> case input of
        UpdateCount count ->
          [ A.Empty
          , A.Push $ PH.text (show count)
          ]
    , PH.button
        [ PP.onClick \_mouseEvent -> Just UserClickedReset
        ]
        [ PH.text "Reset"
        ]
    ]

subscription :: FRP.Event Message
subscription = empty
