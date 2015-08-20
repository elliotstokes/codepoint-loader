{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Environment (getArgs)
import System.IO
import Control.Monad
import DataTypes
import Data

import Data.Csv (decode, HasHeader( NoHeader))
import qualified Data.Vector as V
import qualified Data.ByteString.Lazy as L

validateArgs :: [String] -> Either String String
validateArgs (x:[]) = Right x
validateArgs _ = Left "Only takes one parameter" 

loadFile :: String -> IO ()
loadFile f = do
  putStrLn $ "Loading" ++ f
  csv <- L.readFile f
  case decode NoHeader csv :: Either String (V.Vector CodePoint) of 
    Left err -> putStrLn "Error"
    Right v -> V.forM_ v $ \c-> do
      putStrLn $ postcode c
      insertCodePoint c


main :: IO ()
main = do
  putStrLn "CSV Parser" 
  args <- liftM validateArgs getArgs 
  case args of 
    Left err -> putStrLn err
    Right f -> loadFile f
  putStrLn "ok"

