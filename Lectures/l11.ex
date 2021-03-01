defmodule Notes do

  @doc """
    Concurrency:(The illusion of) happening at the same time
    A property of the programming model
    Why would we want to do things concurrently -> Makes things easier

    *Shared memory: modify a shared data structure
    ----> Comes from the hardware perspective
    -> C++/C
    -> Java
    - >>>> Very easy to fuck things up


    * Message passing: Processes and receive messages
      --> Comes from the programmers pespective
    -> Erlang/Elixir
    -> Go
    -> Scala
    -> RUst (like c++ but better)
    -> Smalltalk(old langauge that uses this model)

    Communication Sequential Processes (CSP) messages are sent through channels, a process can
    choose to read a message from one or more channels
    -> Go, Occam, Rust

    Actor model, messages are sent to a process, a process reads implicity from its own channel
    -> State : Keeps a private state that can only be changed by the actor
    -> Receive: Given a state and a received message, the actor can
              -> Speed : Send a number of messages to other actors
              -> Spawn: Create a number of new actors
              -> Transform: Modify its state and continue or terminate

    Is the set of messages to an actor orded

    In what order should the messages be handled

    The evuation of a function is deterministic, how about the execution of an actor

    How can an actor direct a message to a specific actor

    Do we have a global naming scheme

    What should we do if we're sending a message to an actor that has been terminated
    ->Erlang is asynchronous

    What if we're waiting for a message that will never be sent?
    -> 2 case. 1 case if the message didnt come then we cut it. 2 Case if the message
    is on it's way but we cut it. Distributed System tackles this problem

    Are sent messages guarenteed to arrive?
    ->

    We introduce one additional data structure:

    Structures = {Process identifier} Atom U {{s1,s2}|si -> Structures}

    There is no term, nor pattern that corresponds to an identifier

    A new process is pawned by giving it a function to evuatlion
     -> The result is a process identifier

     id = sapwn(module,name,[arg...])


    """
end


defmodule Foo do

  # Pid -> A process identifier as a data structure
  # Spawn -> Creating a process, returning a pid
  # Send -> Sending of messages to a pid
  # Receieve -> Selective receieve of messages
  # Self -> The process identifier of the current process

  # All constructs can, part from the receieve statemetn, almost be given a functional
  # interpretation

  # Out operational semantics does not give us any understannding of the execution

  @doc """
  Messages passing: unreliable FIFO -> First in, first out

  send(pid({:this,:is:message,1})
  send(pid{:this,:is:message,2})
  send(pid{:this,:is,:message,3})





  """

  def sum(s) do
    receive do
      {:add,x} -> sum(s+x)
      {:sub,x} -> sum(s-x)
      {:mul,x} -> sum(s*x)
    end
  end

  def closed(s) do
    receive do
      {:add,x} -> closed(x+s)
      :open -> open(s)
      :done ->{:ok,s}
    end
  end

  def open(s) do
    receive do
      {:mul,x} -> open(s*x)
      {:sub,x} -> open(s-x)
      :close -> closed(s)
    end
  end



  def start() do
    receive do
      {:Hello, msg} ->
        IO.puts("wow #{msg}")
        start()
      :quit ->
        :ok
    end
  end

  def server(sum) do
    receive do
      {:add, x} ->
        server(sum+x)
      {:sub,x} ->
        server(sum-x)
    end
  end

  def acc(saldo) do
    receive do
      {:desposit, money} ->
        acc(saldo+money)
      {:withdraw,money} ->
        acc(saldo - money)
      {:request,from} ->
        send(from,{:saldo,saldo})
        acc(saldo)
    end
  end

  def check(acc) do
    send(acc,{:request,self()})
    receive do
      {:saldo, saldo} ->
        saldo
    end
  end

  def doit() do
    acc = spawn(fn() -> acc(0) end)
    send(acc,{:deposit,20})
    send(acc,{:withdraw,10})
    acc
  end

end
