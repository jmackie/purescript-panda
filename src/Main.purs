module Main where

import Control.Monad.Eff (Eff)
import Control.Plus      (empty)
import Panda             as P
import Panda.HTML        as PH
import Panda.Property    as PP
import Prelude


data NumberPickerEvent
  = NumberPickerIncrement
  | NumberPickerDecrement


view ∷ ∀ eff. P.Component eff Unit Int NumberPickerEvent
view
  = PH.div_
      [ PH.button
          [ PP.onClick \_ → NumberPickerDecrement
          ]

          [ PH.text "-"
          ]

      , PH.watchAny \{ state } →
          PH.text (show state)

      , PH.button
          [ PP.onClick \_ → NumberPickerIncrement
          ]

          [ PH.text "+"
          ]
      ]


update
  ∷ ∀ eff
  . ((Int → { update ∷ Unit, state ∷ Int }) → Eff eff Unit)
  → { event ∷ NumberPickerEvent, state ∷ Int }
  → Eff eff Unit
update dispatcher { event, state }
  = void $ dispatcher \_ →
      { update: unit
      , state: case event of
          NumberPickerIncrement → state + 1
          NumberPickerDecrement → state - 1
      }

main ∷ ∀ eff. Eff (P.FX eff) Unit
main
  = P.runApplication
      { view
      , update
      , subscription: empty
      , initial:
          { update: unit
          , state: 0
          }
      }

