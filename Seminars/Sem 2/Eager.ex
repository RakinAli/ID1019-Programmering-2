defmodule Eager do

  @doc """
  {:atm,a}
  {:var,v}
  {:cons,head,tail}
  """

  #Looks for an item in a list
  def lookup(_,[]) do
    nil
  end

  #If we found the binding of id -> return the id togetther with it's binding
  def lookup(id,[{id,str}|_]) do
    {id,str}
  end

  #Look in the tail for the id
  def lookup(id,[_|t]) do
    lookup(id,t)
  end


  #This function will evaluate expressions
  def eval_expr({:atm, id},_) do
    {:ok,id}
  end

  #Checks if the variable is in the enviroment then check what value it is mapped to
  def eval_expr({:var, id}, env) do
    case lookup(id,env) do
      nil ->
        :error
      {_, str} ->
        {:ok,str}
    end
  end

  #Evalutate variable & atom then enviroement
  def eval_expr({:cons,variable,atom},env) do
    case eval_expr(variable,env) do
      :error ->
        :error
      {:ok, variableBinding} ->
        case eval_expr(atom,env) do
          :error ->
            :error
          {:ok, atomBinding} ->
              {:ok,[variableBinding,atomBinding]}
        end
    end
  end




end
