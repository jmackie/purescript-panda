{ name =
    "panda-examples"
, dependencies =
    (./../spago.dhall).dependencies # [ "console", "debug" ]
, packages =
    ./../packages.dhall
, sources =
    [ "../src/**/*.purs"
    , "./counter/**/*.purs"
    , "./sign-up/**/*.purs"
    , "./todomvc/**/*.purs"
    ]
}
