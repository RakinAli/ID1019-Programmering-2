defmodule Vector do

  #Vector scalar multiplication
  def smul({x1, x2, x3}, s) do
    {x1*s,x2*s,x3*s}
  end

  #Vector subtraction
  def sub({x1, x2, x3}, {y1, y2, y3}) do
    {x1-y1,x2-y2,x3-y3}
  end

  #Vector addition
  def add({x1, x2, x3}, {y1, y2, y3}) do
    {x1+y1,x2+y2,x3+y3}
  end

  #Calculatae the length of a vector
  def norm({x1, x2, x3}) do
    :math.sqrt((x1*x1)+(x2*x2)+(x3*x3))
  end

  def dot({x1, x2, x3}, {y1, y2, y3}) do
    {x1*y1 + x2*y2 + x3*y3}
  end

  def normalize(x) do
    norm = norm(x)
    smul(x,1/norm)
  end
end

defmodule Ray do
  defstruct pos: {0,0,0}, dir: {1,1,1}
end

defprotocol Object do

  def intersect(object, ray)

end

defmodule Sphere do

  defstruct pos: {0, 0, 0}, radius: 2


  defimpl Object do

    #If intersect return {:ok,d} else return :no
    def intersect(sphere = %Sphere{},ray = %Ray{}) do
      k = Vector.sub(sphere.pos,ray.pos)
      a = Vector.dot(k,ray.dir)
      a2 = a*ak2
      k2 = Vector.norm(k) * Vector.norm(k)
      r2 = sphere.radius * sphere.radius
      t2 = a2-k2+r2
      if t2<0 do
        :no
      else
        t = :math.sqrt(t2)
        calcDistance(t,a)
      end
    end

    #Defined privately in the module Sphere
    defp calcDistance(t,a) do
      d1 = a-t
      d2 = a+t
      cond do
        d1 >0.0 and d2> 0.0 ->
          {:ok,min(d1,d2)}
        d1 > 0.0 ->
          {:ok,d1}
        d2 > 0.0 ->
          {:ok,d2}
        true ->
          :no
      end
    end
  end
end

defmodule Camera do

  defstruct(
    pos: nil,
    corner: nil,
    right: nil,
    down: nil,
    size: nil
  )

  def normal(size) do
    {width, height} = size
    d = width * 1.2
    h = width / 2
    v = height / 2
    corner = {-h,v,d}
      right = {1,0,0}
      down = {0,-1,0}
    %Camera{pos: {0, 0, 0}, corner: corner, right: right, down: down, size: size}
  end




end
