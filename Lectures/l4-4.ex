defmodule Tree do

  def insert(key,value,:nil) do
    {:node,key,value,:nil,:nil}
  end

  def insert(key,value,{:node,k,v,left,right}) do
    if key<k do
      {:node,k,v,insert(key,value,left),right}
    else
      {:node,k,v,left,insert(key,value,right)}
    end
  end


#Trying to make a look up function

  #Nothing to find - Empty
  def lookup(_,:nil) do
    :no
  end

  #Found the key
  def lookup(key,{:node,key,value,_,_}) do
    {:value,value}
  end

  #Look left or right in the tree
  def lookup(key,{:node,k,_,left,right}) do
    if key<k do
      lookup(key,left)
    else
      lookup(key,right)
    end
  end

#Trying to modify a value in a branch
  def modify(_,_,:nil) do
    :nil
  end

  def modify(key,value,{:node,key,_,left,right}) do
    {:node,key,value,left,right}
  end

  def modify(key,value,{:node,k,v,left,right}) do
    if key<k do
      {:node,k,v,modify(key,value,left)}
    else
      {:node,k,v,left,modify(key,value,right)}
    end
  end
end
