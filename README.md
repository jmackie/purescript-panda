# Panda 🐼

[![Build Status](https://travis-ci.org/jmackie/purescript-panda.svg?branch=master)](https://travis-ci.org/jmackie/purescript-panda)

Panda is a PureScript UI library for building declarative front-ends without a
virtual DOM. To achieve this, dynamic events are specifically labelled and
configured to produce specific event listeners, and updates are localised to
the tree underneath.

![Panda](https://raw.githubusercontent.com/i-am-tom/purescript-panda/master/panda.png)

## Getting started

```
import Panda as P
import Panda.HTML as PH
import Panda.Property as PP
```

## Concepts

A component in `panda` has the type:

```
P.Component Input Output Message State
```

### `Input`

An `Input` is a command that will in some way influence the DOM presentation.

### `Output`

An `Output` is a message that can be emitted by a component. The parent of a
component will generally map child `Outputs` to it's own `Message` type.

### `Message`

A `Message` is an _internal_ event that is handled by the component's `update`
function.

## Module Skeleton

```
import Prelude
import Control.Plus (empty)
import Effect (Effect)
import FRP.Event as FRP
--
import Panda as P
import Panda.HTML as PH

main :: Effect Unit
main = do
  _ <- P.runApplicationInBody application
  pure unit

type Input
  = Unit

data Message
  = NoOp

type State
  = Unit

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
  , state: unit
  }

update :: forall output. P.Updater Input output Message State
update _emit _dispatch { message, state } = do
  case message of
    NoOp -> pure unit

view :: PH.HTML Input Message State
view = PH.text "TODO"

subscription :: FRP.Event Message
subscription = empty
```
