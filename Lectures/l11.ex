

defmodule Concurrency do

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
    - >



  """

end
