defmodule Tree do

  #We are making a Binary search Tree

  #If there's nothing -> return zero
  def member(_,:nil) do
    :no
  end

  # If the element is inside the leaf
  def member(elem,{:leaf,elem}) do
    :yes
  end

  #If the element is not inside a leaf
  def member(_,{:leaf,_}) do
    :no
  end

  # If the element is inside a branch
  def member(elem,{:node,elem,_,_}) do
    :yes
  end

  #Looking deep inside the branch 
  def member(elem,{:node,_,left,right}) do
    case member(elem,left) do
      :yes -> :yes
      :no -> case member(elem,right) do
        :yes -> :yes
        :no -> :no
      end
    end
  end
end
