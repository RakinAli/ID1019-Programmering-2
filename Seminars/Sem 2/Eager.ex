defmodule Eager do

  #This function will evaluate expressions 
  def eval_expr({:atm, id}, ...) do

  end

  def eval_expr({:var, id}, env) do
    case ... do
      nil ->
        ...
      {_, str} ->
        ...
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
