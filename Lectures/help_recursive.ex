defmodule LST do

  # Pack([:a,:b,:c,:b,:a]) =>

  def pack([]) do
    []
  end

  def pack([h|t]) do
    packed = pack(t)
    insert(h,packed)
  end

  #Base case for insert
  def insert(h,[]) do
    [[h]]
  end

  def insert(h,[[h|t]|rest]) do
    [[h,h|t] | rest]
  end

  def insert(h,[first|rest]) do
    [first|insert(h,rest)]
  end

end
