defmodule Lists do

  #Tak takes an argument and reutnrs the first element of a list
  def tak([]) do
    "Empty list"
  end

  def tak([h|_]) do
    h
  end

  #Deletes the header and returns the tail of the list
  def drp([]) do
    "Nothing to delete"
  end

  def drp([_|t]) do
    t
  end


  #Len -> returns the length of the list
  def len([]) do
    len([],0)
  end

  def len([h|t]) do
    len([h|t],0)
  end

  def len([],n) do
    n
  end

  def len([_|t],n) do
    len(t,n+1)
  end

  #Sum -> Returns the sum of the list
  def sum([]) do
    sum([],0)
  end

  def sum([h|t]) do
    sum([h|t],0)
  end

  def sum([])




end
