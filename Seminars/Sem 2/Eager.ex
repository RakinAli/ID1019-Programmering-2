defmodule Eager do

  @doc """
  {:atm,a}
  {:var,v}
  {:cons,head,tail}
  """



  #This function will evaluate expressions
  def eval_expr({:atm, id},_) do
    {:ok,id}
  end

  #Checks if the variable is in the enviroment then check what value it is mapped to
  def eval_expr({:var, id}, env) do
    case Env.lookup(id,env) do
      nil ->
        :error
      {_, str} ->
        {:ok,str}
    end
  end

  def eval_expr({:cons, ..., ...}, ...) do
    case eval_expr(..., ...) do
      :error ->
        ...
      {:ok, ...} ->
        case eval_expr(..., ...) do
          :error ->
            ...
          {:ok, ts} ->
            ...
        end
    end
  end
end
