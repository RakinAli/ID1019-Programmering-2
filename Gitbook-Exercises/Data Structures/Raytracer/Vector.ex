defmodule Vector do

  #Scalar multiplication
  def smul({x1,x2,x3},s) do
    {x1*s,x2*s,x3*s}
  end

  #Subtraction of two vectors -> Returns a vector
  def sub({x1,x2,x3},{y1,y2,y3}) do
    {x1-y1,x2-y2,x3-y3}
  end

  #Addition of two vectores -> Returns a vector
  def add({x1,x2,x3},{y1,y2,y3}) do
    {x1+y1,x2+y2,x3+y3}
  end

  #Calculates the norm of a vector -> Returns a scalar
  def norm({x1,x2,x3}) do
    x = x1*x1 + x2*x2 + x3*x3
    xx = :math.sqrt(x)
    xx
  end

  #Calculates the dot product of a vector -> Returns a scalar
  def dot({x1,x2,x3},{y1,y2,y3}) do
    x1*y1 + x2*y2 + x3*y3
  end

  #Normalizes a vector 
  def normalize(x) do
    norm = Vector.norm(x)
    smul(x,1/norm)
  end




end
