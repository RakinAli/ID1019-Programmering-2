
#Defines Vector functions
defmodule Vector do

  @doc """
  A lot of the code is in this defmodule is directly taken from the lecture slides
  https://people.kth.se/~johanmon/courses/id1019/lectures/tracer.pdf
  """

  #Scalar multiplication in 3D
  def smul({x1, x2, x3}, s) do
    {x1*s,x2*s,x3*s}
  end

  #Vector minus vector
  def sub({x1, x2, x3}, {y1, y2, y3}) do
    {x1-y1,x2-y2,x3-y3}
  end

  #Vector plus vector
  def add({x1, x2, x3}, {y1, y2, y3}) do
    {x1+y1,x2+y2,x3+y3}
  end

  #Norm of a vector -> The length of a vector. Pytagoras theorem
  def norm({x1, x2, x3}) do
    :math.sqrt(x1*x2 + x2*x2 + x3*x3)
  end

  #Vector times a vector -> gives a scalar
  def dot({x1, x2, x3}, {y1, y2, y3}) do
    x1*y1 + x2*y2 + x3*y3
  end

  #All the vectors multiplied by (1/norm) gives the normalize
  def normalize(x) do
    norm = norm(x)
    smul(x,1/norm)
  end
end

#This is the Ray module we use to crate a Ray
defmodule Ray do

  @doc """
  Remeber that a ray is a vector. This w
  """


  #defines the position of the ray and the direction as well
  defstruct pos: {0, 0, 0}, dir: {1, 1, 1}
end

#We define how an object
defprotocol Object do

  def intersect(object, ray)

end

defmodule Sphere do

  #Predefined positions and properties
  defstruct pos: {0, 0, 0}, radius: 2

end

defimpl Object do

  #First calculate the length of a -> Done by takin dot product of k and l.
  #Vector K is easy calculated since we know origin of ray o and the center of C
  def intersect(sphere = %Sphere{}, ray = %Ray{}) do

    #Take the center of the spwhere minus the starting of the ray -> K
    vec_k = Vector.sub(sphere.pos,ray.pos)

    vec_a_length = Vector.dot(vec_k,ray.dir)

    # H is root(normK squared + vec_a squared)
    vec_k2 = Vector.norm(vec_k) * Vector.norm(vec_k)
    a2 = vec_a_length * vec_a_length

    h2_length = vec_k2-a2

    #r2 minus h2 gives us t2. If t2 is negative then we done else find the clostest disntance
    r2 = sphere.radius * sphere.radius
    t2 = r2 - h2_length

    if t2=<0 do
      :no
    else
      #t2 becomes t
      t = :math.sqrt(t2)
      d1 = vec_a_length - t
      d2 = vec_a_length + t


      #Case 1 -> If both distances are larger than zero
      if(d1>0 && d2>0 ) do
        if d1>d2 do
          {:ok,d2}
        else
          {:ok,d1}
        end
      end
      #Case 2 -> If both distances are smaller than zero
      if(d1<0 && d2<0) do
        if d1>d2 do
           {:ok,d2}
        else
          {:ok,d1}
        end
      end
    end
  end
end

defmodule Camera do

  #Whenever we call Camera module
  defstruct pos: nil, corner: nil, right: nil, down: nil, size: nil

  def normal(size) do
    {width, height} = size
    d = width * 1.2
    h = width / 2
    v = height / 2
    corner = {-h,v,d}
      pos = {0,0,0}
      right = {1,0,0}
      down = {0,-1,0}
    %Camera{pos: {0, 0, 0}, corner: corner, right: {1,0,0},down: {0,-1,0}, size: size)
  end

  #Rays coming out of the camera
  def ray(%Camera{pos: pos, right: right, down: down, corner: corner}, x, y) do
    x_pos = Vector.smul(right, x)
    y_pos = Vector.smul(down, y)
    pixle = Vector.add(corner, Vector.add(x_pos, y_pos))
    dir = Vector.normalize(pixle)
    %Ray{pos: pos, dir: dir}
  end
end


defmodule World do

  defstruct objects: []

end

defmodule Tracer do

  @black {0, 0, 0}
  @white {1, 1, 1}


  def tracer(camera, objects) do
    {w, h} = camera.size
    for y <- 1..h, do: for(x <- 1..w, do: trace(x, y, camera, objects))
  end

  def trace(x, y, camera, objects) do
    ray = Camera.ray(camera, x, y)
    trace(ray, objects)
  end

  def trace(ray, objects) do
    case intersect(ray, objects) do
      {:inf, _} ->
        @black

      {_, _} ->
        @white
    end
  end

  def intersect(ray, objects) do
    List.foldl(objects, {:inf, nil}, fn (object, sofar) ->
      {dist, _} = sofar

      case Object.intersect(object, ray) do
        {:ok, d} when d < dist ->
          {d, object}
        _ ->
          sofar
      end
    end)
  end

end
