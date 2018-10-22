module Lib
    ( listSum
    , listProduct
    , listConcat
    , listMaximum
    , listMinimum
    , sum
    , concat
    , length
    , elem
    , safeMaximum
    , safeMinimum
    , any
    , all
    , foldr
    , Complex(..)
    ) where

import Prelude hiding (foldr, maximum, minimum, any, all, length
                      , concat, sum, product, elem, Foldable(..))

-- TASK 2
-- Bounded parametric polymorphism

-- Implement the following functions that reduce a list to a single
-- value (or Maybe a single value).

-- Maybe is imported from Prelude and is defined like this:
-- data Maybe a = Just a | Nothing

listSum :: (Num a) => [a] -> a
listSum [] = 0
listSum (x:xs) = x + listSum xs

listProduct :: (Num a) => [a] -> a
listProduct [] = 1
listProduct (x:xs) = x * listProduct xs

listConcat :: [[a]] -> [a]
listConcat [] = []
listConcat (x:xs) = x ++ listConcat xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort [y | y <- xs, y <= x] ++ [x] ++ quicksort [y | y <- xs, y > x]

listMaximum :: (Ord a) => [a] -> Maybe a
listMaximum [] = Nothing
listMaximum xs = Just $ last $ quicksort xs

listMinimum :: (Ord a) => [a] -> Maybe a
listMinimum [] = Nothing
listMinimum xs = Just $ head $ quicksort xs

-- TASK 3 Folds

-- TASK 3.1
-- Below our Foldable class is defined. Now define a list instance of
-- Foldable, and then define the Foldable versions of the functions
-- you defined previously (and some more).
class Foldable t where
  foldr :: (a -> b -> b) -> b -> t a -> b

instance Foldable [] where
  foldr f acc [] = acc
  foldr f acc (x:xs) =  foldr f (f x acc) xs
   
--
-- USE FOLDR TO DEFINE THESE FUNCTIONS
--
sum :: (Num a, Foldable t) => t a -> a
sum xs = foldr (+) 0 xs

concat :: Foldable t => t [a] -> [a]
concat xs = foldr (\x acc -> acc ++ x) [] xs

length :: Foldable t => t a -> Int
length xs = foldr (\x acc -> acc + 1) 0 xs

elem :: (Eq a, Foldable t) => a -> t a -> Bool
elem n xs = foldr (\x acc -> if x == n then True else acc) False xs

safeMaximum :: (Foldable t, Ord a) => t a -> Maybe a
safeMaximum = undefined
--safeMaximum xs = Just $ foldr (\x acc -> if x > acc then x else acc) ...... xs

safeMinimum :: (Foldable t, Ord a) => t a -> Maybe a
safeMinimum = undefined
--safeMinimum xs = Just $ foldr (\x acc -> if x < acc then x else acc)  ..... xs

-- The functions "any" and "all" check if any or all elements of a
-- Foldable satisfy the given predicate.
--
-- USE FOLDR
--
any :: Foldable t => (a -> Bool) -> t a -> Bool
any p xs = foldr (\x acc -> if (p x) then True else acc) False xs

all :: Foldable t => (a -> Bool) -> t a -> Bool
all p xs = foldr (\x acc -> if (p x) then acc else False) True xs

-- TASK 4
-- Num Complex
 
data Complex = Complex Double Double deriving (Eq) 
 
instance Show Complex where 
    show (Complex r i) 
        | i >= 0 = show r ++ "+" ++ show i ++ "i" 
        | otherwise = show r ++ "-" ++ show (abs i) ++ "i" 

instance Num Complex where
    (+) (Complex r1 i1) (Complex r2 i2) = Complex (r1 + r2) (i1 + i2)
    (*) (Complex r1 i1) (Complex r2 i2) = Complex (r1*r2 - i1*i2) (r1*i2 + i1*r2)
    abs (Complex r i) = Complex (sqrt (r*r + i*i)) 0
    --signum z = z / abs(z)
    fromInteger x = Complex (fromIntegral x) 0
    (-) (Complex r1 i1) (Complex r2 i2) = Complex (r1 - r2) (i1 - i2)

-- TASK 5
-- Making your own type classes

type Position = (Double, Double)

class Pos a where
    pos :: a -> Position

data Campus = Kalvskinnet
            | Gløshaugen
            | Tyholt
            | Moholt
            | Dragvoll
            deriving (Show, Eq)

instance Pos Campus where
    pos Kalvskinnet = (63.429, 10.388)
    pos Gløshaugen  = (63.416, 10.403)
    pos Tyholt      = (63.423, 10.435)
    pos Moholt      = (63.413, 10.434)
    pos Dragvoll    = (63.409, 10.471)

class (Pos a) => Move a where
    shift :: a -> Position
  
data Person = Person { firstName :: String
                    , lastName :: String  
                    , age :: Int  
                    }  



data Car = Car { plate :: String
                --, company :: String
                --, model :: String
                --, year :: Int
                --  , freeCar :: Bool
                --  , x :: Position
                --  , keys :: Key
                } deriving(Show)
                
instance Eq Car where
    (==) p1 p2 = plate p1 == plate p2
    
instance Pos Car where
     pos x = (63.429, 10.388)
     
instance Move Car where
     shift x = (63.416, 10.403)
                
data Key = Key {  car :: Car
                  , freeKeys :: Bool }

instance Eq Key where
    (==) c1 c2 = car c1 == car c2
    
instance Pos Key where
     pos car = (63.429, 10.388)
     
instance Move Key where
     shift car = (63.416, 10.403)

free :: Move a => a -> Bool
free c = pos c == shift c

--carAvailable :: Car -> Bool
--carAvailable c = freeCar c && freeKeys (keys c)

--istanceBetween :: Pos a => a -> a -> Int
--distanceBetween c1 c2 = x car 
                
        
                
                
                
                
                
                
                
                
                
                
