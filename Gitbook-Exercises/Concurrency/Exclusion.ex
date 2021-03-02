defmodule Cell do

  #We create a cell over here
  def new(), do: spawn_link(fn -> cell(:open) end)



  #We define a cell over here
  defp cell(state) do
    receive do
      {:get, from} ->
        send(from, {:ok, state})
        cell(state)

      {:set, value, from} ->
        send(from, :ok)
        cell(value)
    end
  end

  #Here we get a cell
  def get(cell) do
    send(cell, {:get, self()})
    receive do
      {:ok, value} -> value
    end
  end

  #Here we set the value of the cell
  def set(cell, value) do
    send(cell, {:set, value, self()})
    receive do
      :ok -> :ok
    end
  end



  #A test function
  def do_it(thing, lock) do
    case Cell.get(lock) do
      :taken ->
        do_it(thing, lock)
      :open ->
        Cell.set(lock, :taken)
        do_ya_critical_thing(thing)
        Cell.set(lock, :open)
    end
  end

end
