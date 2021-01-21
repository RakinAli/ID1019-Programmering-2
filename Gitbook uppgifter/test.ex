defmodule Test do

  #Computes the double of a number
  def double(n) do
    n*2
  end

  #Converts Fahrenheit to Celsius
  def fahren2cel(x) do
    (x-32)/1.8
  end

  #A function that calculates teh area of a rectange given the length of the two sides
  def rectange(x,y)do
    x*y
  end

  #A function that calculates the area of a square using the previous function
  def square(x) do
    rectange(x,x)
  end

  #A function that calculates the area of a cirlce given the radius
  def circle(r) do
    (r*r)*3.14

  end


end
