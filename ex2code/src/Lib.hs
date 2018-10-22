module Lib
    ( f0
    , f1
    , f2
    , take
    , map
    , iterate
    , filterPos
    , filterPosMany
    , flip3
    , Maybe(..)
    , safeHeadList
    , safeHead
    ) where

import Prelude hiding (map, take, iterate, sqrt, Maybe)

-- TASK 1
-- Parametric polymorphism

-- Below are three type signatures. Can you implement them? We
-- say a function or implementation /inhabits/ it's type
-- (signature). How many other inhabitants do these types
-- have? What if we fixed a = Int, does that change your
-- previous answer?
f0 :: a -> a
f0 = \a -> a

f1 :: a -> b -> a
f1 = \a b -> a

f2 :: a -> b -> b
f2 = \a b -> b

-- Rewrite the function "takeInt" from exercice 1 as "take" so
-- that it accepts a list of any type. If you used the
-- built-in function "take" on the last assignment, write your
-- own implementation this time. Be sure to include a type
-- signature. (Hint: If you already wrote takeInt, you won't
-- have to change much.)
take :: Int -> [a] -> [a]
take n a = (if n<=0 || null a then [] else (head a):(take (n-1) (tail a)))

-- The function head :: [a] -> a which returns the first
-- element of a list, is /partial/, meaning it will crash for
-- some inputs. (Which?) One solution could be to make a
-- /total/ function "safeHeadList :: [a] -> [a]" which either
-- gives the head, or nothing. Can you implement it using take?
--Empty list
safeHeadList :: [a] -> [a]
safeHeadList = \a -> take 1 a

-- The output of safeHeadList is either empty or a singleton,
-- and thus using a list as output-type is a bit misleading. A
-- better choice is Maybe (sometimes called Optional):
data Maybe a = Some a | None deriving (Eq, Show)
--constructors : 
--Some :: a -> Maybe a   ||examples : Some a  :: Maybe Int 
--None :: Maybe a
-- Implement 'safeHead', representing failure using None.
safeHead :: [a] -> Maybe a
safeHead = \a -> (if null a then None else Some (head a))

-- TASK 2
-- Higher order functions

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

iterate :: (a -> a) -> a -> [a]
iterate f x = x : iterate f (f x)

-- TASK 3
-- Currying and partial application

-- complete the function filterPos
-- that takes a list and returns 
-- a filtered list containing only positive
-- integers (including zero)
-- use partial application to achieve this
filterPos :: [Int] -> [Int]
filterPos = \l -> [x | x <- l, not (x<0)]

-- complete the function filterPosMany
-- that takes a list of lists and returns
-- a list of lists with only positive
-- integers (including zero)
-- hint: use filterPos and map
filterPosMany :: [[Int]] -> [[Int]]
filterPosMany = \l -> map filterPos l

flip3 :: (a -> b -> c -> d) -> c -> b -> a -> d
flip3 = \f a b c-> f c b a

-- TASK 4
-- Infinite lists

isPerfSq :: Double -> Bool
isPerfSq = 

--uncomment when isPerfSqr is defined
--accuracy :: Int -> Bool
--accuracy x = take x generated == take x [x^2 | x <- [1..]]
--                where
--             zpd       = zip [1..] (map isPerfSq [1..])
--             f (x,y)   = y == True
--             generated = fst . unzip $ filter f zpd
