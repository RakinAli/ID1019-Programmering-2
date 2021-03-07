defmodule Mandel do

  #We want to generate an image of the size Width by Height. The upper left corner of this image
  # is to the point x+yi and the offset between two points is K- This means that the first pixels
  # of the upper row should correspond to the "depth" of $$x+yi$, $(x+k) + yi$, $(x+2k) + yi$$ etc and that the second row starts with $x + (y-k)i$.
  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
      Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end

    rows(width, height, trans, depth, [])
  end

  def demo() do
    small(-2.6, 1.2, 1.2)
  end

  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 64
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small.ppm", image)
  end

  #If we have no height -> Case closed
  def rows(_,0,_,_,rows) do
    rows
  end

  #
  def rows(width,height,trans,depth,rows) do
    rows(width,height-1,trans,depth,[row(width,height,trans,depth,[])|rows])
  end

  def row(0,_,_,_,row) do
    row
  end

  def row(width,height,trans,depth,row) do
    color = Colors.convert(Brot.mandelbrot(trans.(width, height), depth), depth)
    row(width - 1, height, trans, depth, [color | row])
  end
end
