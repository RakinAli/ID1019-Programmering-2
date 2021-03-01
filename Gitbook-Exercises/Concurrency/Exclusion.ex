defmodule Cell do

  @doc """
  We wills tart by implement a lock processs. A lock is somethat that can only
  be held by one process, the process that takes the lock knows that it is the sole
  owner of the lock and can proceed to a critical section

  Out first attemp to implement a lock is quite straight forward - we will implement
  the lock as a process that only holds one value and accepts two messages: set and get
  """

  def new(), do: spawn_link(fn -> cell(:open) end)

  # A private function.
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

  @doc """
  To make it easier to use the lock we also provide two functions that hide the fact that we do
    asynchronous communication.

  """
  def get(cell) do
    send(cell, {:get, self()})
    receive do
      {:ok, value} -> value
    end
  end

  def set(cell, value) do
    send(cell, {:set, value, self()})
    receive do
      :ok -> :ok
    end
  end

  @doc """
  If we have created a cell we could use it to protect a crtical operation using the codes that
  follows (not true so don't stop reading here)
  """
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

  @doc """
  Perfect, cased closed... ehhh there is something wrong, - Before you think about
  what would happen if two processes called the do_it/2 producere with the same lock; do we
  guarentee that the two processes will never execute the critical section at the same timE?

  There are two solutions to the problem of the lock in the first section: atomic swap and
  Petersons algorithm. Using atmoic swap we implement a new message that will read and write to the
  cell in the same operation. This feature is often found in harsare and programs written in C can often make
  direct use of this. In our implementation we will implmeent it ourselves with a samll exension to the lock

  """

  defp cell(state) do
    receive do
      {:swap, value, from} ->
        send(from, {:ok, state})
        cell(value)
      {:set, value, from} ->
        send(from, :ok)
        cell(value)
    end
  end

  #Assuming we also provide a functional interface we could now use the lock as follows:
  def do_it(thing, lock) do
    case Cell.swap(lock, :taken) do
      :taken ->
        do_it(thing, lock)
      :open ->
        do_ya_critical_thing(thing)
        Cell.set(lock, :open)
    end
  end

  def lock(id, m, p, q) do
    Cell.set(m, true)
    other = rem(id + 1, 2)
    Cell.set(q, other)

    case Cell.get(p) do
      false ->
        :locked
      true ->
        case Cell.get(q) do
          ^id ->
            :locked
          ^other ->
            lock(id, m, p, q)
        end
    end
  end

  def unlock(_id, m, _p, _q) do
    Cell.set(m, false)
  end

  def semaphore(0) do
    receive do
      :release ->
        semaphore(1)
    end
  end

  def semaphore(n) do
    receive do
      {:request, from} ->
        send(from, :granted)
        semaphore(n - 1)
      :release ->
        semaphore(n + 1)
    end
  end

  def request(semaphore) do
    send(semaphore, {:request, self()})
    receive do
      :granted ->
        :ok
    end
  end

  def monitor(state) do
    receive do
      {:request, from} ->
        updated = critical(state)
        send(from, :ok)
        monitor(updated)
    end
  end

  def monitor(state) do
    receive do
      {:request, fun, from} ->
        updated = fun.(state)
        send(from, :ok)
        monitor(updated)
    end
  end

  def request(semaphore) do
    send(semaphore, {:request, self()})
    receive do
      :granted ->
        :ok
    after
      1000 ->
        :abort
    end
  end

  def request(semaphore) do
    ref = make_ref()
    send(semaphore, {:request, ref, self()})
    wait(semaphore, ref)
  end

  def wait(semaphore, ref) do
    receive do
      {:granted, ^ref} ->
        :ok
      {:granted, _} ->
        wait(semaphore, ref)
    after
      1000 ->
        send(semaphore, :release)
        :abort
    end
  end







end
