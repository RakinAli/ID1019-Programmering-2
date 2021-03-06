defmodule Brot do

  @type complex :: {:cmplx,number,number}

  @spec mandelbrot(complex,number) :: number
  def mandelbrot(complex,max) do
    z0 = Cmplx.new(0,0)
    i = 0
    test(i, z0, complex, max)
  end

  @type test (number,complex,complex,number) :: number





end
