module Panda.Builders.HTML.Collection where

import Data.Algebra.Array as Algebra
import Data.Function (on)
import Data.Maybe (fromJust)
import Partial.Unsafe (unsafePartial)
import Prelude

-- | Sort a list of some Ord type, returning both the sorted list and the
-- | required DOM operations to reflect this in some list of children.
sort ::
  forall a b.
  Ord a ⇒
  Array a ->
  { state :: Array a
  , moves :: Array (Algebra.Update b)
  }
sort = sortBy compare

-- | Sort a list using some comparator, returning both the sorted list and the
-- | required DOM operations to reflect this in some list of children.
sortBy ::
  forall a b.
  (a -> a -> Ordering) ->
  Array a ->
  { state :: Array a
  , moves :: Array (Algebra.Update b)
  }
sortBy comparison focus =
  { state: unsafePartial fromJust (Algebra.interpret focus instructions)
  , moves: instructions
  }
  where
  instructions ::
    forall anything.
    Array (Algebra.Update anything)
  instructions = Algebra.sortBy comparison focus

  sorted = Algebra.interpret focus instructions

-- | Sort a list by mapping its elements to some comparable type, returning
-- | both the sorted list and the required DOM operations to reflect this in
-- | some list of children.
sortWith ::
  forall a b c.
  Ord b ⇒
  (a -> b) ->
  Array a ->
  { state :: Array a
  , moves :: Array (Algebra.Update c)
  }
sortWith = sortBy <<< on compare
