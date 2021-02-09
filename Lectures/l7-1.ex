defmodule High do

  def foldr([],acc,_op) do
    acc
  end

  def foldr([h|t],acc,op) do
    op.(h,foldr(t,acc,op))
  end

  def foldl([],acc,_op) do
    acc
  end

  def foldl([h|t],acc,op) do
    foldl(t,op.(h,acc),op)
  end

  def appendr(l) do
    f = fn(e,a) -> e++a end
    foldr(l,[],f)
  end

  def appendr(l) do
    f = fn(e,a) -> a++e end
    foldl(l,[],f)
  end



end
