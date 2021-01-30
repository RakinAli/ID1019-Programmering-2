defmodule Test do

 # :nil    -> Empty tree
 #{:leaf,value}    -> a Leaf
 #{:node, value, left, right}   -> a Branch

   #_____________________________ MEMBER FUNCTION ______________________-

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

   def testMember() do

   end
   #__________________________________________________________--

   #___________________ INSERT FUNCTION _______________________

   #Creates a root
   def insert(e,:nil) do
      {:leaf,e}
   end

   #Transform the leaf into a node then create a leaf on the left side
   def insert(e,{:leaf,v}) when e<v do
      {:node,v,{:leaf,e},:nil}
   end

   #Else transform the leaf into a node then create a leaf on the right side
   def insert(e,{:leaf,v}) do
      {:node,v,:nil,{:leaf,e}}
   end

   #Insert an element on the left if e is larger than v
   def insert(e,{:node,v,left,right}) when e < v do
      {:node,v,insert(e,left),right}
   end

   def insert(e,{:node,v,left,right}) do
      {:node,v,left,insert(e,right)}
   end

   def testInsert() do

   end
   #____________________________________________________________

   #______________________ Delete function _____________________


   #Deletes a leaf
   def delete(e,{:leaf,e}) do
      :nil
   end

   #Case 1- If we delete a node and the leftside is empty -> Just connect right
   def delete(e,{:node,e,:nil,right})do
      right
   end

   def delete(e,{:node,e,left,:nil}) do
      left
   end

   def delete(e,{:node,e,left,right}) do
      
   end



end
