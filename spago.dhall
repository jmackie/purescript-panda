{ name =
    "pandas"
, dependencies =
    [ "prelude"
    , "foldable-traversable"
    , "random"
    , "simple-json"
    , "affjax"
    , "generics-rep"
    , "data-algebrae"
    , "web-html"
    , "web-uievents"
    , "behaviors"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs" ]
}
