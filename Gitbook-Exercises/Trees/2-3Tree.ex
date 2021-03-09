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

  #If our root is a four node
  def insert(k, v, root) do
    case insertf(k, v, root) do
      {:four, q1, q2, q3, t1, t2, t3, t4} ->
        # Special case for the root of the tree, never want to end up with a four node.
        {:two, q2, {:two, q1, t1, t2}, {:two, q3, t3, t4}}

      updated ->
        updated
    end
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
        {:three,k1,k,l1,{:leaf,k,v},l2}

      #Our key becomes the rightmost leaf
      true ->
        {:three,k1,k2,l1,l2,{:leaf,k,v}}
    end
  end

  #To prevent four nodes
  def insertf(k, v, {:two, k1, left, right}) do
    cond do
      #If the k is smaller than k1 -> Insert it to the left
      k <= k1 ->
        case insertf(k, v, left) do
          #In the case that we have a 4 node -> Split it into a three node
          #where q1 becomes "left and q3 becomes middle and right becomes right
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:three,q2,k1,{:two,q1,t1,t2},{:two,q3,t3,t4}, right}
          updated ->
            {:two, k1, updated, right}
        end
      #If the k is larger than k1 -> Insert to the right
      true ->
        case insertf(k, v, right) do
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:three, k1, q2, left, {:two, q1, t1, t2}, {:two, q3, t3, t4}}

          updated ->
            {:two, k1, left, updated}
        end
    end
  end

  def insertf(k, v, {:three, k1, k2, {:leaf, k1, _} = l1, {:leaf, k2, _} = l2, {:leaf, k3, _} = l3}) do
    cond do
      #If the key we want to add is the smallest
      k <= k1 ->
        {:four,k,k1,2,{:leaf,k,v},l2,l3}
      #If the key we want to add is the second smallest
      k <= k2 ->
        {:four,k1,k,k2,l1,{:leaf,k,v},l2,l3}
      #If the key we want to add is the second largest
      k <= k3 ->
        {:four,k1,k2,k,l1,l2,{:leaf,k,v},l3}
      #If the key we want to add is the largest
      true ->
        {:four,k1,k2,k3,l1,l2,l3,{:leaf,k,v}}
    end
  end

  def insertf(k, v, {:three, k1, k2, left, middle, right}) do
    cond do
      #Edit the leftmost
      k <= k1 ->
        case insertf(k, v, left) do
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:four, q2, k1, k2,{:two,q1,t1,t2},{:two,q3,t3,t4}, middle,right}
            #Afterwards
          updated ->
            {:three, k1, k2,updated,middle,right}
        end

        #Edit the middle tree
      k <= k2 ->
        case insertf(k, v, middle) do
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:four,k1,q2,k2,left,{:two,q1,t1,t2},{:two,q3,t3,t4},right}
          updated ->
            {:three, k1, k2,left,updated,right}
        end

      true ->
        case insertf(k, v, right) do
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:four, k1, k2, q2, left, middle, {:two, q1, t1, t2}, {:two, q3, t3, t4}}
          updated ->
            {:three, k1, k2,left,middle,updated}
        end
    end
  end

  #Tests to create a 3 nodes root
  def test1() do
    tree = nil
    a = insertf(1,:a,tree)
    b = insertf(2,:b,a)
    c = insertf(3,:c,b)
    d = insertf(4,:d,c)
    d
  end

  def test do
    insertf(14, :grk, {:two, 7, {:three, 2, 5, {:leaf, 2, :foo},
        {:leaf, 5, :bar}, {:leaf, 7, :zot}}, {:three, 13, 16,
        {:leaf, 13, :foo}, {:leaf, 16, :bar}, {:leaf, 18, :zot}}})
  end


end
