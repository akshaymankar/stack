import Control.Monad (when)
import StackTest

main :: IO ()
main = do
  stackCheckStdout ["ls", "dependencies", "--tree"] $ \stdOut -> do
    let expected = unlines [ "Packages"
                           , "├─┬ files 0.1.0.0"
                           , "│ ├─┬ base 4.10.1.0"
                           , "│ │ ├─┬ ghc-prim 0.5.1.1"
                           , "│ │ │ └── rts 1.0"
                           , "│ │ ├─┬ integer-gmp 1.0.1.0"
                           , "│ │ │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │ │   └── rts 1.0"
                           , "│ │ └── rts 1.0"
                           , "│ ├─┬ mtl 2.2.2"
                           , "│ │ ├─┬ base 4.10.1.0"
                           , "│ │ │ ├─┬ ghc-prim 0.5.1.1"
                           , "│ │ │ │ └── rts 1.0"
                           , "│ │ │ ├─┬ integer-gmp 1.0.1.0"
                           , "│ │ │ │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │ │ │   └── rts 1.0"
                           , "│ │ │ └── rts 1.0"
                           , "│ │ └─┬ transformers 0.5.2.0"
                           , "│ │   └─┬ base 4.10.1.0"
                           , "│ │     ├─┬ ghc-prim 0.5.1.1"
                           , "│ │     │ └── rts 1.0"
                           , "│ │     ├─┬ integer-gmp 1.0.1.0"
                           , "│ │     │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │     │   └── rts 1.0"
                           , "│ │     └── rts 1.0"
                           , "│ └─┬ subproject 0.1.0.0"
                           , "│   └─┬ base 4.10.1.0"
                           , "│     ├─┬ ghc-prim 0.5.1.1"
                           , "│     │ └── rts 1.0"
                           , "│     ├─┬ integer-gmp 1.0.1.0"
                           , "│     │ └─┬ ghc-prim 0.5.1.1"
                           , "│     │   └── rts 1.0"
                           , "│     └── rts 1.0"
                           , "└─┬ subproject 0.1.0.0"
                           , "  └─┬ base 4.10.1.0"
                           , "    ├─┬ ghc-prim 0.5.1.1"
                           , "    │ └── rts 1.0"
                           , "    ├─┬ integer-gmp 1.0.1.0"
                           , "    │ └─┬ ghc-prim 0.5.1.1"
                           , "    │   └── rts 1.0"
                           , "    └── rts 1.0"
                           ]
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]

  stackCheckStdout ["ls", "dependencies", "--tree", "--depth=1"] $ \stdOut -> do
    let expected = unlines [ "Packages"
                           , "├─┬ files 0.1.0.0"
                           , "│ ├── base 4.10.1.0"
                           , "│ ├── mtl 2.2.2"
                           , "│ └── subproject 0.1.0.0"
                           , "└─┬ subproject 0.1.0.0"
                           , "  └── base 4.10.1.0"
                           ]
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]

  stackCheckStdout ["ls", "dependencies", "--tree", "subproject"] $ \stdOut -> do
    let expected = unlines [ "Packages"
                           , "└─┬ subproject 0.1.0.0"
                           , "  └─┬ base 4.10.1.0"
                           , "    ├─┬ ghc-prim 0.5.1.1"
                           , "    │ └── rts 1.0"
                           , "    ├─┬ integer-gmp 1.0.1.0"
                           , "    │ └─┬ ghc-prim 0.5.1.1"
                           , "    │   └── rts 1.0"
                           , "    └── rts 1.0"
                           ]
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]

  -- stackCheckStdout ["ls", "dependencies", "--tree", "--no-include-base"] $ \stdOut -> do
  --   let expected = unlines [ "Packages"
  --                          , "└─┬ files 0.1.0.0"
  --                          , "  └── mtl 2.2.2"
  --                          ]
  --   when (stdOut /= expected) $
  --     error $ unlines [ "Expected:", expected, "Actual:", stdOut ]

  stackCheckStdout ["-v", "ls", "dependencies", "--no-include-base"] $ \stdOut -> do
    let expected = unlines [ "Packages"
                           , "└─┬ files 0.1.0.0"
                           , "  └── mtl 2.2.2"
                           ]
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]

