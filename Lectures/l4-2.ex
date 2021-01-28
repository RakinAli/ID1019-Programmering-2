defmodule Q do

  def new() do
    {:Q,[],[]}
  end

  def add({:Q,front,back},elem) do
    {:Q,front,[elem|back]}
  end

  def add([h|t],elem) do
    [h|add(t,elem)]
  end

  def remove({:Q,[],[]}) do
    :error
  end

  def remove({:Q,[],back}) do
    remove({:Q,reverse(back),[]})
  end

  def remove({:Q,[elem|rest],back}) do
    {:ok,elem,{:Q,rest,back}}
  end

  def reverse(lst) do
    reverse(lst,[])
  end

  def reverse([],rev) do
    rev
  end

  def reverse([h|t],rev) do
    reverse(t,[h|rev])
  end

end
