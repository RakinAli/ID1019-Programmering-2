#From Garry to learn Concurreny. Not from the gitbook excercises

defmodule M do

  def do_stuff do
    #Spawns a process that runs the function loop
    spawn(fn()->loop(50,1) end )
    spawn(fn()->loop(100,1) end )

    send(self(),{:french,"Bob"})

    receive do
      {:german, name} ->
          IO.puts("Guten tag #{name}")
      {:french, name} ->
          IO.puts("Bonjour #{name}")
      {:english, name} ->
          IO.puts("Hello #{name}")

    after
      500->IO.puts"Time up"
      end
    #If there's no matching word
  end

  # A Elixir for loop
  # What happens if the 1st attribute is 0
  def loop(0,_), do: nil

  def loop(max, min) do
    if max < min do
      loop(0, min)
    else
      IO.puts "Num : #{max}"
      loop(max - 1, min)
    end
  end


end
