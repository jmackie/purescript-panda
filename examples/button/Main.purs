module Main where

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

type Input
  = Unit

type Output
  = Void

data Message
  = Increment
  | Reset

type State
  = Int

application :: P.Component Input Output Message State
application =
  { initial
  , update
  , view
  , subscription
  }

initial :: { input :: Input, state :: State }
initial =
  { input: unit
  , state: 0
  }

update :: P.Updater Input Output Message State
update _emit dispatch { message, state: s } = do
  case message of
    Increment ->
      dispatch \currentState ->
        { input: Just unit -- view doesn't update if this is `Nothing`
        , state: currentState + 1
        }
    Reset ->
      dispatch \_ ->
        { input: Just unit -- view doesn't update if this is `Nothing`
        , state: 0
        }

view :: PH.HTML Input Message State
view =
  PH.div_
    [ PH.button'
        [ PP.onClick \_mouseEvent -> Just Increment
        ] \{ state } ->
        [ A.Empty
        , A.Push $ PH.text (show state)
        ]
    , PH.button
        [ PP.onClick \_mouseEvent -> Just Reset
        ]
        [ PH.text "Reset"
        ]
    ]

subscription :: FRP.Event Message
subscription = empty
