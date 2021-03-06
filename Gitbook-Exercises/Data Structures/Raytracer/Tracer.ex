defmodule Tracer do

  def intersect(ray, objects) do
    List.foldl(objects, {:inf, nil}, fn(object, sofar) ->
      {dist, _} = sofar

      case Object.intersect(object, ray) do
        {:ok, d} when d < dist ->
          {d, object}
        _ ->
          sofar
      end
    end)
  end

  def trace(x, y, camera, world) do
    ray = Ray.ray(camera,x,y)
    trace(ray, world)
  end

  def trace(ray, %World{objects: objects} = world) do
    case intersect(ray, objects) do
      ... ->
        @black
      ... ->
        @white
    end
  end



end
