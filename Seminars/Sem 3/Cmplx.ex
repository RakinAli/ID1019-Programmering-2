defmodule Cmplx do
  @type complex :: {:cmplx,number,number}

  #Creates a tuple of a complex number
  def new(real,im) do
    {:cmplx,real,im}
  end

  #Addition of complex numbers
  def add({:cmplx,r1,i1},{:cmplx,r2,i2}) do
    {:cmplx,r1+r2,i1+i2}
  end

  #Square of a complex number
  def sqr({:cmplx,real,im}) do
    {:cmplx,real*real-im*im,2*real*im}
  end

  #Absolute value of a complex number
  def abs({:cmplx,real,im}) do
    :math.sqrt(real*real + im*im)
  end

end
