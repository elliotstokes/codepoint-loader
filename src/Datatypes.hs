module DataTypes where

import Data.Csv (FromRecord (parseRecord), (.!))
import           Database.PostgreSQL.Simple.FromRow
import           Database.PostgreSQL.Simple.ToRow
import           Database.PostgreSQL.Simple.ToField

data CodePoint = CodePoint {
  postcode :: String,
  accuracy :: Int,
  eastings :: Int,
  northings :: Int
}

instance FromRecord CodePoint where
  parseRecord v = CodePoint <$> v .! 0 <*> v .! 1 <*> v.! 2 <*> v.! 3

instance FromRow CodePoint where
  fromRow = CodePoint <$> field <*> field <*> field <*> field

instance ToRow CodePoint where
  toRow r = [toField $ postcode r, toField $ accuracy r, toField $ eastings r, toField $ northings r]




