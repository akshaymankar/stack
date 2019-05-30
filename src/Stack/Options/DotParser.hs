{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Stack.Options.DotParser where

import           Data.Char (isSpace)
import           Data.List.Split (splitOn)
import qualified Data.Set as Set
import qualified Data.Text as T
import           Distribution.Types.PackageName(PackageName, mkPackageName)
import           Options.Applicative
import           Options.Applicative.Builder.Extra
import           Stack.Dot
import           Stack.Options.BuildParser
import           Stack.Prelude

-- | Parser for arguments to `stack dot`
dotOptsParser :: Bool -> Parser DotOpts
dotOptsParser externalDefault =
  DotOpts <$> includeExternal
          <*> includeBase
          <*> depthLimit
          <*> fmap (maybe Set.empty Set.fromList . fmap splitNames) prunedPkgs
          <*> targetsParser
          <*> flagsParser
          <*> testTargets
          <*> benchTargets
          <*> globalHints
  where includeExternal = boolFlags externalDefault
                                    "external"
                                    "inclusion of external dependencies"
                                    idm
        includeBase = boolFlags True
                                "include-base"
                                "inclusion of dependencies on base"
                                idm
        depthLimit =
            optional (option auto
                             (long "depth" <>
                              metavar "DEPTH" <>
                              help ("Limit the depth of dependency resolution " <>
                                    "(Default: No limit)")))
        prunedPkgs = optional (strOption
                                   (long "prune" <>
                                    metavar "PACKAGES" <>
                                    help ("Prune each package name " <>
                                          "from the comma separated list " <>
                                          "of package names PACKAGES")))
        testTargets = switch (long "test" <>
                              help "Consider dependencies of test components")
        benchTargets = switch (long "bench" <>
                               help "Consider dependencies of benchmark components")

        splitNames :: String -> [PackageName]
        splitNames = map (mkPackageName . takeWhile (not . isSpace) . dropWhile isSpace) . splitOn ","

        globalHints = switch (long "global-hints" <>
                              help "Do not require an install GHC; instead, use a hints file for global packages")

-- | Parser for arguments to `stack ls dependencies`.
listDepsOptsParser :: Parser ListDepsOpts
listDepsOptsParser = ListDepsOpts
                 <$> dotOptsParser True -- Default for --external is True.
                 <*> fmap escapeSep
                     (textOption (long "separator" <>
                                  metavar "SEP" <>
                                  help ("Separator between package name " <>
                                        "and package version.") <>
                                  value " " <>
                                  showDefault))
                 <*> boolFlags False
                                "license"
                                "printing of dependency licenses instead of versions"
                                idm
                 <*> boolFlags False
                                "tree"
                                "printing of dependencies as a tree"
                                idm
  where escapeSep sep = T.replace "\\t" "\t" (T.replace "\\n" "\n" sep)
