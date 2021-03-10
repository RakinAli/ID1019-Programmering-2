defmodule Splay do
  @doc """
  Zig Roration -> Every node moves one position to the right from it's current position

  Zag Rotation -> Every node moves on position to the left from it's current position

  Zig Zig rotation -> Every node moves two position to the right from it's current position

  Zag zag rotation -> Every node moves two position to the left from it's current positon

  Zig Zag -> Right then left.

  Zag Zig -> Left then right

  """

  @type tree :: nil | {:node,key,value,left,right}

  #Case 1 -> When tree is empty
  def update(nil, key, value) do
    {:node,key,value,nil,nil}
  end

  #Case 2 -> We've found what we're looking for and it is at the root
  def update({:node, key, _, a, b}, key, value) do
    {:node,key,value,a,b}
  end

  #Case 3- > Zig transformation(right)
  #-> Move the root to the right and insert the new the "root"
  #-> First we take the entire left branch and move it to the "right"
  def update({:node, rk, rv, zig, c}, key, value) when key < rk do
    # The general rule where we will do the Zig transformation.
    {:splay, _, a, b} = splay(zig, key)
    {:node,key,value,a, {:node,rk,rv,b,c}}
  end

  #Case 4-> Zag transformation(left)
  def update({:node, rk, rv, a, zag}, key, value) when key >= rk do
    # The general rule where we will do the Zag transformation.
    {:splay, _, b, c} = splay(zag, key)
    {:node, ..., ..., {:node, ..., ..., ..., ...}, ...}
  end

  #Takes a tree and a key and will return a tuple: either¨
  # 1-> {:splay,kv,a,b} where kv is the value of hte key
  # 2-> {:na,...} if the key us not found and a and b
  defp splay(nil, _) do
    {:splay, :na,nil,nil}
  end

  defp splay({:node, key, value, a, b}, key) do
    {:splay,value,a,b}
  end






end
