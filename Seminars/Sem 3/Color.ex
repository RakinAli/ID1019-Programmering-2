defmodule Colors do

  @type color ::  {:rgb,0..255,0..255,0..255}

  @spec convert(number,number) :: color

  def convert(depth,max) when depth > max do
    {:error, "Depth>Max"}
  end


  @moduledoc """
  Let's assume that we have a depth of a point, with the maximum possible depth being. We could create five sections that divides the range to.
  Divide by and so that you have a fraction. Then multiply this fraction by four to generate a floating point from to.
  Now truncate the value to give you an integer from to (this is the section) and generate an offset that is the truncated value of .
  """
  def convert(depth,max) do
    a = (depth/max) * 4
    x = trunc(a)
    y = round((255)*(a-x))
    case x do
      0 -> {:rgb, y, 0, 0}
      1 -> {:rgb, 255, y, 0}
      2 -> {:rgb, 255 - y, 255, 0}
      3 -> {:rgb, 0, 255, y}
      _ -> {:rgb, 0, 255-y, 255}
    end
  end




end
