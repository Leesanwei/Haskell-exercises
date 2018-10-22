module Tree
    (Tree(..)
    ) where

-- TASK 3.2
-- Binary Trees
                     
data Tree a = Branch (Tree a) a (Tree a) | Leaf a
  deriving (Eq, Show)

-- The Foldable instance might prove tricky to define, so
-- defining the specific functions first may be easier!
treeSum :: (Num a) => Tree a -> a
treeSum t = foldr (+) 0 t

treeConcat :: Tree String -> String
treeConcat t = foldr (\x acc -> acc ++ x) "" t

treeMaximum :: (Ord a) => Tree a -> a
treeMaximum = undefined
--treeMaximum t = foldr (\x acc -> if x > acc then x else acc) ...... t

-- Write a Foldable instance for Tree.
instance Foldable Tree where
    foldr f acc (Leaf x) = f x acc
    foldr f acc (Branch l x r) = foldr f (f x (foldr f acc r)) l
  
 