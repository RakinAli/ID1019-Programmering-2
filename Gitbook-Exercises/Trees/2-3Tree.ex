defmodule Tree do

  @doc """
  The empty tree -> :nil
  a leaf ->     {:leaf,key,value}
  a two node:   {:two,key,left,right}
  a three node  {:three, k1,k2,left,middle,right}
  a four node:  {:four, k1,k2,k3,left,m1,m2,right}
  """
  
  #Rules of Insertions
  @moduledoc """
  We have some simple cases in the bottom of three and then some tricky cases where we end
  up with a four-node. Let's start with a description of the simple cases:
  1. -> Empty tree: To insert a key-value pair in an empty tree return a leaf contaiing the key and value
  2. ->A leaf: To insert a key-value pair in a leaf return a two node containing the existing leaf and a new
      leaf. The smaller of the keys should be the key of the two node.
  """

  #Let's implmenet a function that takes a key, valuye and a 2-3 tree and returns a 2-3 tree or possible
  # a four node containing 2-3 trees of equal depth. Look at the rules and start with the base caes

  # (key,value,tree) -> In the arguments Key-Value is the value we want to add

  #If we have no root. -> Insert a root
  def insertf(key, value, nil) do
    {:leaf, key, value}
  end

  #If we have a root and want to add our first element to the root -> Create a two node
  def insertf(k, v, {:leaf, k1, _} = l) do
    cond do
      #If the root value is larger than the element, we place the our value to the left
      k <= k1 ->
        {:two, k, {:leaf, k, v}, l}
      #Else to the right.
      true ->
        {:two, k1, l, {:leaf, k, v}}
    end
  end

  #A two-node that holds only leaves, and we want to insert a key-value pair
  def insertf(k, v, {:two, k1, {:leaf, k1, _} = l1, {:leaf, k2, _} = l2}) do
    cond do
      #if our key we want to insert is smaller than the current key of the two node -> {:three,k,k1}
      k <= k1 ->
        {:three,k,k1,{:leaf,k,v},l1,l2}
      #If our key we want to insert becomes the "middle" leaf
      k <= k2 ->
        {:three,k1,k,l1,{:leaf,k,v}.l2}

      #Our key becomes the rightmost leaf
      true ->

    end
  end





end
