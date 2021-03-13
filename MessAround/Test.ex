defmodule Holf do

  def tripler(value,function) do
    3* function.(value)
  end
end

defmodule Wait do

  #The IO.puts procedure will output the string to the stdout and isnert the x value by
  #means of string interpolation. Compile and load the above module in the Elixir interactive shell
  #iex. (the returned PID number may be different)

  def hello do
    receive do
        x -> IO.puts("aaa! surprise, a message: #{x}")
    end
  end

end
