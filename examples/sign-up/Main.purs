module Example.SignUp.Main (main) where

import Prelude
import Control.Plus (empty)
import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Aff (Aff, delay, runAff)
--
import Panda as P
import Panda.HTML as PH
--
import Example.SignUp.Form as Form

-- | Because we want to respond to events from the signup form, we need to have
-- | internal message representation for our top-level application. As it
-- | stands, we only care about login attempts.
data Message
  = MakeLoginAttempt
    ( (Form.State -> Aff (Array Form.Error)) ->
      Aff Unit
    )

-- | We export from the Form module as a delegate, so when we embed the html
-- | elsewhere, we only really need to say how to convert our inputs into its
-- | inputs, and its outputs into our messages. These are the only channels for
-- | communication between a delegate and its parent.
view ::
  forall input.
  PH.HTML input Message Unit
view =
  Form.application
    { input: \_ -> Nothing
    , output:
      case _ of
        Form.LoginAttempted handle -> Just (MakeLoginAttempt handle)
    }

-- | At the top level, we've nothing to emit here (because we don't have some
-- | containing listener such as React). All we do is dispatch updates to the
-- | form, which we can fake for the demo.
update ::
  forall input output.
  P.Updater input output Message Unit
update _emit dispatch { message: MakeLoginAttempt handle } = do
  _ <-
    runAff mempty
      $ handle \state -> do
          delay (Milliseconds 2000.0)
          pure
            [ Form.InvalidPassword
            ]
  pure unit

-- | At the top-level, we build an application just like any other, but then
-- | `runApplication` within some container (in this case, the body).
main :: Effect Unit
main = do
  _ <-
    P.runApplicationInBody
      $ { view
        , update
        , subscription: empty
        , initial:
          { input: Form.ResetForm
          , state: unit
          }
        }
  pure unit
