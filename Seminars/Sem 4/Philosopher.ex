defmodule Philosopher do

  @dream 1000
  @eat 50
  @delay 200
  @ms 200

  #This function will wait for a number of milliseconds before continuing. If you want
  # to have some randomness you can use the library function.
  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end

  #Hunger -> The number of times the philosopher should it before it sends a :done
  #Strength -> The strength, when down to zero the philosopher dies
  #right and left -> The process identifier of the two chopstick
  #name -> A string that is hte name of the philosopher used for nice loggin
  #Ctrl: A controller process that should be informed when the philoshopher is done
  #Seed: A unique number to intiate a random sequence NOT USED

  def start(hunger,right,left,name,ctrl) do
    philosopher = spawn_link(fn->createPhilosopher(hunger,right,left,name,ctrl)end)
  end

  def createPhilosopher(hunger,right,left,name,ctrl) do
    dreamingPhil(hunger,right,left,name,ctrl)
  end

  def dreamingPhil(hunger,right,left,name,ctrl) do
    #Prints this out for our terminal
    IO.puts("#{name} is dreaming..." )
    #The amount of time spent dreaming before waiting for food
    sleep(@dream)
    waiting(hunger,right,left,name,ctrl)
  end

  def waiting(hunger,right,left,name,ctrl) do
    IO.puts("#{name} is waiting... ")
    case Chopstick.request(left,@ms) do
      :ok ->
          case Chopstick.request(right,@ms) do
            :ok ->
              IO.puts("#{name} will eat now! ")
              eating(hunger,right,left,name,ctrl)
          end
    end
  end

  def eating(hunger,right,left,name,ctrl) do
    IO.puts("#{name} is eating...")
    sleep(@eat)
    Chopstick.return(left)
    Chopstick.return(right)
    dreamingPhil(hunger-1,right,left,name,ctrl)
  end


  def sleep(0) do :ok end
  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end





end
