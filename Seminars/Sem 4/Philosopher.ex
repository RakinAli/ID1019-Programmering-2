defmodule Philosopher do

  #Dreaming
  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end

  #Done sleeping
  def sleep(0) do
    :ok
  end

  #Starting process
  def start(hunger,strength,right,left,name,ctrl,seed) do
    phil = spawn(fn->createPhil(hunger,strength,right,left,name,ctrl,seed)end)
  end

  def createPhil(hunger,strength,right,left,name,ctrl,seed) do
    dreaming(hunger,right,left,name,ctrl,seed)
  end

  def dreaming(hunger,_,right,left,name,strl,seed) do

  end



end
