import Control.Monad (when)
import StackTest

main :: IO ()
main = do
  stackCheckStdout ["ls", "dependencies", "tree"] $ \stdOut -> do
    let expected = unlines [ "Packages"
                           , "├─┬ files 0.1.0.0"
                           , "│ ├─┬ base 4.10.1.0"
                           , "│ │ ├─┬ ghc-prim 0.5.1.1"
                           , "│ │ │ └── rts 1.0"
                           , "│ │ ├─┬ integer-gmp 1.0.1.0"
                           , "│ │ │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │ │   └── rts 1.0"
                           , "│ │ └── rts 1.0"
                           , "│ ├─┬ filelock 0.1.1.2"
                           , "│ │ ├─┬ base 4.10.1.0"
                           , "│ │ │ ├─┬ ghc-prim 0.5.1.1"
                           , "│ │ │ │ └── rts 1.0"
                           , "│ │ │ ├─┬ integer-gmp 1.0.1.0"
                           , "│ │ │ │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │ │ │   └── rts 1.0"
                           , "│ │ │ └── rts 1.0"
                           , "│ │ └─┬ unix 2.7.2.2"
                           , "│ │   ├─┬ base 4.10.1.0"
                           , "│ │   │ ├─┬ ghc-prim 0.5.1.1"
                           , "│ │   │ │ └── rts 1.0"
                           , "│ │   │ ├─┬ integer-gmp 1.0.1.0"
                           , "│ │   │ │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │   │ │   └── rts 1.0"
                           , "│ │   │ └── rts 1.0"
                           , "│ │   ├─┬ bytestring 0.10.8.2"
                           , "│ │   │ ├─┬ base 4.10.1.0"
                           , "│ │   │ │ ├─┬ ghc-prim 0.5.1.1"
                           , "│ │   │ │ │ └── rts 1.0"
                           , "│ │   │ │ ├─┬ integer-gmp 1.0.1.0"
                           , "│ │   │ │ │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │   │ │ │   └── rts 1.0"
                           , "│ │   │ │ └── rts 1.0"
                           , "│ │   │ ├─┬ deepseq 1.4.3.0"
                           , "│ │   │ │ ├─┬ array 0.5.2.0"
                           , "│ │   │ │ │ └─┬ base 4.10.1.0"
                           , "│ │   │ │ │   ├─┬ ghc-prim 0.5.1.1"
                           , "│ │   │ │ │   │ └── rts 1.0"
                           , "│ │   │ │ │   ├─┬ integer-gmp 1.0.1.0"
                           , "│ │   │ │ │   │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │   │ │ │   │   └── rts 1.0"
                           , "│ │   │ │ │   └── rts 1.0"
                           , "│ │   │ │ └─┬ base 4.10.1.0"
                           , "│ │   │ │   ├─┬ ghc-prim 0.5.1.1"
                           , "│ │   │ │   │ └── rts 1.0"
                           , "│ │   │ │   ├─┬ integer-gmp 1.0.1.0"
                           , "│ │   │ │   │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │   │ │   │   └── rts 1.0"
                           , "│ │   │ │   └── rts 1.0"
                           , "│ │   │ ├─┬ ghc-prim 0.5.1.1"
                           , "│ │   │ │ └── rts 1.0"
                           , "│ │   │ └─┬ integer-gmp 1.0.1.0"
                           , "│ │   │   └─┬ ghc-prim 0.5.1.1"
                           , "│ │   │     └── rts 1.0"
                           , "│ │   └─┬ time 1.8.0.2"
                           , "│ │     ├─┬ base 4.10.1.0"
                           , "│ │     │ ├─┬ ghc-prim 0.5.1.1"
                           , "│ │     │ │ └── rts 1.0"
                           , "│ │     │ ├─┬ integer-gmp 1.0.1.0"
                           , "│ │     │ │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │     │ │   └── rts 1.0"
                           , "│ │     │ └── rts 1.0"
                           , "│ │     └─┬ deepseq 1.4.3.0"
                           , "│ │       ├─┬ array 0.5.2.0"
                           , "│ │       │ └─┬ base 4.10.1.0"
                           , "│ │       │   ├─┬ ghc-prim 0.5.1.1"
                           , "│ │       │   │ └── rts 1.0"
                           , "│ │       │   ├─┬ integer-gmp 1.0.1.0"
                           , "│ │       │   │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │       │   │   └── rts 1.0"
                           , "│ │       │   └── rts 1.0"
                           , "│ │       └─┬ base 4.10.1.0"
                           , "│ │         ├─┬ ghc-prim 0.5.1.1"
                           , "│ │         │ └── rts 1.0"
                           , "│ │         ├─┬ integer-gmp 1.0.1.0"
                           , "│ │         │ └─┬ ghc-prim 0.5.1.1"
                           , "│ │         │   └── rts 1.0"
                           , "│ │         └── rts 1.0"
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

  stackCheckStdout ["ls", "dependencies", "tree", "--depth=1"] $ \stdOut -> do
    let expected = unlines [ "Packages"
                           , "├─┬ files 0.1.0.0"
                           , "│ ├── base 4.10.1.0"
                           , "│ ├── filelock 0.1.1.2"
                           , "│ ├── mtl 2.2.2"
                           , "│ └── subproject 0.1.0.0"
                           , "└─┬ subproject 0.1.0.0"
                           , "  └── base 4.10.1.0"
                           ]
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]

  stackCheckStdout ["ls", "dependencies", "tree", "subproject"] $ \stdOut -> do
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

  stackCheckStdout ["ls", "dependencies", "json"] $ \stdOut -> do
    let expected = "[{\"name\":\"unix\",\"version\":\"2.7.2.2\",\"license\":\"BSD3\"},{\"name\":\"transformers\",\"version\":\"0.5.2.0\",\"license\":\"BSD3\"},{\"name\":\"time\",\"version\":\"1.8.0.2\",\"license\":\"BSD3\"},{\"location\":{\"url\":\"file:///Users/axeman/work/stack/test/integration/tests/4101-dependency-tree/files/subproject/\",\"type\":\"project package\"},\"name\":\"subproject\",\"version\":\"0.1.0.0\",\"license\":\"AllRightsReserved\"},{\"name\":\"rts\",\"version\":\"1.0\",\"license\":\"BSD3\"},{\"location\":{\"url\":\"https://hackage.haskell.org/package/mtl-2.2.2\",\"type\":\"hackage\"},\"name\":\"mtl\",\"version\":\"2.2.2\",\"license\":\"BSD3\"},{\"name\":\"integer-gmp\",\"version\":\"1.0.1.0\",\"license\":\"BSD3\"},{\"name\":\"ghc-prim\",\"version\":\"0.5.1.1\",\"license\":\"BSD3\"},{\"location\":{\"url\":\"file:///Users/axeman/work/stack/test/integration/tests/4101-dependency-tree/files/\",\"type\":\"project package\"},\"name\":\"files\",\"version\":\"0.1.0.0\",\"license\":\"AllRightsReserved\"},{\"location\":{\"subdir\":\"\",\"url\":\"git@github.com:snoyberg/filelock\",\"type\":\"git\",\"commit\":\"4f080496d8bf153fbe26e64d1f52cf73c7db25f6\"},\"name\":\"filelock\",\"version\":\"0.1.1.2\",\"license\":\"PublicDomain\"},{\"name\":\"deepseq\",\"version\":\"1.4.3.0\",\"license\":\"BSD3\"},{\"name\":\"bytestring\",\"version\":\"0.10.8.2\",\"license\":\"BSD3\"},{\"name\":\"base\",\"version\":\"4.10.1.0\",\"license\":\"BSD3\"},{\"name\":\"array\",\"version\":\"0.5.2.0\",\"license\":\"BSD3\"}]\n"
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]
