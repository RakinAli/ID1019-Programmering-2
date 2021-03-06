defmodule Ray do

  #Starts at position 0,0,0 and has direction 1,1,1
  defstruct pos: {0,0,0}, dir: {1,1,1}

  def ray(camera = %Camera{}, column, row) do

    #Origin of the ray tracer
    origin = camera.pos

    #A vector from the corner to the x column
    x_pos = Vector.smul(camera.right,column)

    #A vector from the corner to the y row
    y_pos = Vector.smul(camera.down,row)

    #The vector between x & y
    v = Vector.add(x_pos,y_pos)

    #Where the pixle lies
    pixle = Vector.add(camera.corner,v)

    #Direction of the ray
    dir = Vector.normalize(pixle)

    %Ray{pos: origin, dir: dir}
  end
end
