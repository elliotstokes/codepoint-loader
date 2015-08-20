{-# LANGUAGE OverloadedStrings #-}

module Data (insertCodePoint) where 

import Database.PostgreSQL.Simple
import DataTypes

getConnection ::  IO (Connection)
getConnection = do
  conn <- connect defaultConnectInfo {
    connectUser = "codepoint",
    connectDatabase = "codepoint"
  }
  return conn

insertCodePoint :: CodePoint -> IO ()
insertCodePoint r = do
  conn <- getConnection
  execute conn "INSERT INTO codepoint (postcode, accuracy, eastings, northings) VALUES (?,?,?,?)" r
  return ()