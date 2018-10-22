module Lib
    ( Token(..)
    , Op(..)
    , takeWhile
    , dropWhile
    , break
    , splitOn
    , lex
    , tokenize
    , interpret
    , shunt
    ) where

import Prelude hiding (lex, dropWhile, takeWhile, break)
import Data.Char (isDigit, isSymbol)

takeWhile, dropWhile :: (a -> Bool) -> [a] -> [a]

takeWhile p xs = [x | x <- xs, (p x)]

dropWhile p xs = [x | x <- xs, not(p x)]

break :: (a -> Bool) -> [a] -> ([a], [a])
break p xs = (findLeft p xs, findRight p xs )

findLeft :: (a -> Bool) -> [a] -> [a]
findLeft _ [] = []
findLeft p (x:xs) = if not $ p x then x : findLeft p xs else []

findRight :: (a -> Bool) -> [a] -> [a]
findRight _ [] = []
findRight p (x:xs)  = if not $ p x then findRight p xs else x : xs

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn _ []  = []
splitOn d lst@(x:xs) = if d == x then splitOn d xs else f : splitOn d rest
                    where (f, rest) = break (== d) lst
  
data Token = TokOp Op
           | TokInt Int
           | TokErr
           deriving (Eq, Show)

data Op = Plus
        | Minus
        | Div
        | Mult
        deriving (Show, Eq)

lex :: String -> [String]
lex xs = splitOn ' ' xs 

tokenize :: [String] -> [Token]
tokenize []  = []
tokenize xs = map tok xs

operator :: Char -> Op
operator o | o == '+' = Plus
           | o == '-' = Minus
           | o == '*' = Mult
           | o == '/' = Div
           
tok :: String -> Token
tok t@(x:xs) | elem x "+-*/" = TokOp (operator x)
             | isDigit x = TokInt (read t)
             | otherwise = TokErr

interpret :: [Token] -> [Token]
interpret xs = foldl f [] xs

f :: [Token] -> Token -> [Token]
f acc t@(TokInt a) = t:acc
f (x:y:acc) t@(TokOp a) = x:acc  


opLeq :: Token -> Token -> Bool
opLeq x y   | x == TokOp Plus = False
            | x == TokOp Minus = False
            | (x == TokOp Mult && y == TokOp Div) = False
            | (x == TokOp Div && y == TokOp Mult) = False
            | otherwise = True

{-
instance Eq TrafficLight where  
    Red == Red = True  
    Green == Green = True  
    Yellow == Yellow = True  
    _ == _ = False  


preced :: Token -> Token -> Bool
preced op1 op2 = op1 > op2
           -- | (op1 == '*' || op1 == '/') && (op2 == '+' || op2 == '-') = True
           -- | otherwise = False
   -}         
shunt :: [Token] -> [Token]
shunt = undefined

shuntInternal :: [Token] -> [Token] -> [Token] -> [Token]
shuntInternal input@(x:xs) output operator  | input == [] = output
                                            | x == TokOp Int = 
