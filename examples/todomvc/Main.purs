module Example.TodoMVC.Main
  ( main
  ) where

import Prelude
import Control.Plus (empty)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console as Console
import FRP.Event as FRP
import Web.Event.Event as Web.Event
import Web.HTML.HTMLInputElement (HTMLInputElement)
import Web.HTML.HTMLInputElement as HTMLInputElement
import Web.UIEvent.KeyboardEvent (KeyboardEvent)
import Web.UIEvent.KeyboardEvent as KeyboardEvent
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

data Message
  = UserClickedEnter KeyboardEvent

type State
  = { entries :: Array Entry
    }

type Entry
  = { description :: String
    , completed :: Boolean
    }

newEntry :: String -> Entry
newEntry description =
  { description
  , completed: false
  }

application :: forall output. P.Component Input output Message State
application =
  { initial
  , update
  , view
  , subscription
  }

initial :: { input :: Input, state :: State }
initial =
  { input: unit
  , state:
    { entries: []
    }
  }

update :: forall output. P.Updater Input output Message State
update _emit dispatch { message, state } = do
  case message of
    UserClickedEnter keyboardEvent -> do
      case inputElementFromKeyboardEvent keyboardEvent of
        Nothing -> Console.log "missing input element"
        Just inputElement -> do
          inputValue <- HTMLInputElement.value inputElement
          Console.log inputValue -- TODO
          HTMLInputElement.setValue "" inputElement

view :: PH.HTML Input Message State
view =
  PH.section
    [ PP.className "todoapp" ]
    [ PH.header
        [ PP.className "header" ]
        [ PH.h1_
            [ PH.text "todos" ]
        , PH.input
            [ PP.className "new-todo"
            , PP.placeholder "What needs to be done?"
            , PP.autofocus "true" -- FIXME
            , onEnter (Just <<< UserClickedEnter)
            ]
        ]
    ]

subscription :: FRP.Event Message
subscription = empty

onEnter :: PP.Producer KeyboardEvent
onEnter tag =
  PP.onKeyUp \keyboardEvent ->
    if KeyboardEvent.key keyboardEvent == "Enter" then
      tag keyboardEvent
    else
      Nothing

inputElementFromKeyboardEvent :: KeyboardEvent -> Maybe HTMLInputElement
inputElementFromKeyboardEvent =
  KeyboardEvent.toEvent
    >>> Web.Event.target
    >=> HTMLInputElement.fromEventTarget
