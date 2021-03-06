defmodule Sphere do

  #The sphere starts at that pos and has r = 2
  defstruct pos: {0,0,0}, radius: 2

  defimpl Object do

    def intersect(sphere = %Sphere{}, ray = %Ray{}) do
      k = Vector.sub(sphere.pos,ray.pos)
      a = Vector.dot(ray.dir,k)
      a2 = a*a
      k2 = Vector.norm(k)*Vector.norm(k)
      r2 = sphere.radius * sphere.radius
      t2 = a2-k2+r2
      closest(t2,a)
    end

    def closest(t2,a) do
      cond do
        t2 < 0 ->
          :no
        true ->
          d1 = a + :math.sqrt(t2)
          d2 = a - :math.sqrt(t2)

          cond do
            d1<0 and d2 <0 ->
              :no
            d1<0 or d2<0 ->
              :no
            true ->
              {:ok,Enum.min([d1,d2])}
          end
      end
    end
  end



end
