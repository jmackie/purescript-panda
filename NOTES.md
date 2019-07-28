Documenting my thinkings as I try and understand this code.

- panda is not a very googleable name.
- Why `runApplicationInBody` not `runComponentInBody`? The type suggests it
  should be called the latter, but if there's a good reason for it to be how
  it is then it's not clear.
- The `initial` field of a `P.Component` is a bad name, can we do better?
- Why do we _need_ and `initial.input`? I'd expect it to be `Maybe`...
- It's a bit suprising that the `subscription` field of `P.Component` is
  singular not plural.
- I don't think `Web.Event.Event` should be re-exported at the top level.
- Need sections on the roles of `input`, `output`, `message` and `state` types.
- Need to document the appropriate names for `Updater` arguments. And what they
  mean/how they work.
- I'd prefer `Panda.Html` to `Panda.HTML`.
- What do the combinations of `'` and `_` mean.
- Wtf is a `Collection`
- Need to export html and property type synonyms so they're visible in the
  generated docs
- Important modules (which are...?) need some high level introduction to names,
  naming conventions and what it all means.
- Wtf is `Data.Array.Algebra`? Do I need this `A.Empty`?
- Why record up `{ message, state }`? Might be easier to treat them separately.
- It wasn't obvious when I should use `state` passed in as an argument to
  `update` and `state` coming from the `dispatch` call.
