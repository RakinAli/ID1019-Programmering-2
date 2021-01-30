defmodule Test do

 # :nil    -> Empty tree
 #{:leaf,value}    -> a Leaf
 #{:node, value, left, right}   -> a Branch


 @doc """
 We start by implementing a function memer/2 that takes an element and
 a tree and determines if the lement is found in the tree or not. Let the
 function return :yes or :no depending on if the element i found

 The first thing you should think about is what the base cases are. An elment
 is of course not found in an empty tree but could be present in a leaf. Note how we
 use _ in third clause; if the lement is not found in the leaf it does not matter what
 we are looking for nor what is in the leaf.
 """

 #If there's no branch or leaf
 def member(_,:nil) do
    :no
 end

 #If the elemt is inside a leaf
 def member(e,{:leaf,e}) do
    :yes
 end

 # If the element we are searching for isn't there
 def member(_,{:leaf,_}) do
   :no
 end

 def member(e,{:node,e,_,_}) do
    :yes
 end

 #If element is larger than v then go left
 def member(e,{:node,v,left,_}) when e < v do
    member(e,left)
 end

#Else go right
 def member(e,{:node,_,_,right})do
   member(e,right)
 end
 
end
