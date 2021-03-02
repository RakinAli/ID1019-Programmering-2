# Taken from this website -> Used to learn concurrency
#https://thoughtbot.com/upcase/videos/concurrency-in-elixir

defmodule Runner do
  def run(owner, task) do
    result = task.()
    send(owner, {:ok, result})
  end
end

defmodule Async do
  def perform(task) do
    owner = self()
    pid = spawn(Runner, :run, [owner, task])

    # We monitor the process just created
    ref = Process.monitor(pid)

    %{ref: ref}
  end


  def resolve(%{ref: ref}) do
    receive do
      {:ok, response} ->
        #Remove the monititor ID
        Process.demonitor(ref, [:flush])
        response
        #
      {:DOWN, ^ref, :process, _from_pid, _exit_reason} ->
        "I'm sorry, the process has failed!"
    end
  end
end



#Async.perform(fn->1+1 end)
#Asynch.resolve()
