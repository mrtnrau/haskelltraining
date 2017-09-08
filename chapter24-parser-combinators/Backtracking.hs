module Backtracking where


import           Control.Applicative
import           Data.Attoparsec.ByteString (parseOnly)
import qualified Data.Attoparsec.ByteString as A
import           Data.ByteString            (ByteString)
import           Data.ByteString.Char8      (pack)
import           Text.Parsec                (Parsec, parseTest)
import           Text.Trifecta              hiding (parseTest)


trifP :: Show a => Parser a -> String -> IO ()
trifP p i = print $ parseString p mempty i


parsecP :: (Show a) => Parsec String () a -> String -> IO ()
parsecP = parseTest


attoP :: Show a => A.Parser a -> ByteString -> IO ()
attoP p i = print $ parseOnly p i


nobackParse :: (Monad f, CharParsing f) => f Char
nobackParse = (char '1' >> char '2') <|> char '3'


tryParse :: (Monad f, CharParsing f) => f Char
tryParse = try (char '1' >> char '2') <|> char '3'


tryAnnot :: (Monad f, CharParsing f) => f Char
tryAnnot = (try (char '1' >> char '2')
        <?> "Tried 12")
        <|> (char '3' <?> "Tried 3")


main :: IO ()
main = do
  -- trifecta
  trifP nobackParse "13"
  trifP tryParse "13"
  trifP tryAnnot "13"
  -- parsec
  parsecP nobackParse "13"
  parsecP tryParse "13"
  parsecP tryAnnot "13"
  -- attoparsec
  attoP nobackParse $ pack "13"
  attoP tryParse $ pack "13"
  attoP tryAnnot $ pack "13"
