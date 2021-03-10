defmodule Brot do

  @type complex :: {:cmplx,number,number}

  @spec mandelbrot(complex,number) :: number

  def mandelbrot(complex,max) do
    z0 = Cmplx.new(0,0)
    i = 0
    test(i, z0, complex, max)
  end

  def test(max,_,_,max) do
    0
  end

  def test(i, z, c, max) do
    if (Cmplx.abs(z)) <= 2.0 do
      test(i+1, Cmplx.add(Cmplx.sqr(z),c), c, max)
    else
      i
    end
  end


end
