defmodule Chopstick do

  #Starts a chopstick FSM
  def start do
    spawn_link(fn -> available() end)
  end

  #Makes a Chopstick avaiable
  def available() do
    receive do
      {:request,from} -> send(from,:granted) gone()
      :quit -> :ok
    end
  end

  def gone() do
    receive do
      :return -> available()
      :quit -> :ok
    end
  end

  def request(stick,ms) do
    send(stick,{:request,self()})
    receive do
      {:granted} -> : ok
    after
      ms-> :no
    end
  end

  #Returns a stick
  def return(stick) do
    send(stick,:return)
  end

  def quit(stick) do
    send(stick,:quit)
  end

end
