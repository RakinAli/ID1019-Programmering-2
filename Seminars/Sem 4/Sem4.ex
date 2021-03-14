defmodule Chopstick do

  #Starts a process
  def start do
    spawn_link(fn -> available() end)
  end

  #Makes a chopstick available
  def available() do
    receive do
      {:request,from} ->
        send(from,:granted)
        gone()
      :quit -> :ok
    end
  end

  #Makes a chopstick unavaiiable
  def gone() do
    receive do
      :return -> available()
      :quit -> :ok
    end
  end

  #A phil request sticks
  def request(stick) do
    send(stick,{:request,self()})
    receive do
      :granted -> :ok
      gone()
    end
  end
end

defmodule Philosopher do

  #Hunger -> The number of times the philosopher should eat before it sends a :done message to the controller process
  #Strength -> When down to zero the phil dies
  #Right and left -> The process identifier of the two chopsticks
  #Name -> A string that is the name of the phil used for nice logging
  #ctrl -> A controller process that should be informed when the phil is done
  #Seed -> A unique number to initiate a random sequence


  #Done sleeping
  def sleep(0) do
    :ok
  end

  #Dreaming
  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end

  #Starting process -> Here we create a Philosopher
  def start(hunger,strength,right,left,name,ctrl,seed) do
    phil = spawn(fn->createPhil(hunger,strength,right,left,name,ctrl,seed)end)
  end

  #The initial state of the phils are in a dreaming state
  def createPhil(hunger,strength,right,left,name,ctrl,seed) do
    dreaming(hunger,strength,right,left,name,ctrl,seed)
  end

  #First they dream then they check left then they wait for food
  def dreaming(hunger,strength,right,left,name,ctrl,seed) do
    #The person is dreaming
    IO.puts("#{name} is dreaming...")
    sleep(seed)
    waiting(hunger,strength,right,left,name,ctrl,seed)
  end

  #A phil is waiting
  def waiting(hunger,strength,right,left,name,ctrl,seed) do
    IO.puts("#{name} is waiting...")
    case Chopstick.request(right) do
      :ok ->
        case Chopstick.request(left) do
          :ok ->
            IO.puts("#{name} had both sticks got picked!")
            eating(hunger,strength,right,left,name,ctrl,seed)
        end
    end
  end

  def eating(hunger,strength,right,left,name,ctrl,seed) do
    IO.puts("#{name} is eating...")
    sleep(seed)
    Chopstick.return(left)
    Chopstick.return(right)
    dreaming(hunger-1,strength,right,left,name,ctrl,seed)
  end
end
