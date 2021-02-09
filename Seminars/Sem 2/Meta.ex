defmodule Enviroment do

  # Sample Sequence: x = _foo; y = :nil; {z, _} = {:bar, :grk}; {x, {z, y}}

  @doc """
  A sequence consist of a, possibly empty, sequence of pattern matching expression followed by a single expression.
  This is a bit more restrictive compared to Elixir sequences but it does not limit the expressiveness of our language.
  Simple expressions will for now be limited to terms. If we use a BNF grammar we can describe a sequence in the following way:
  """

  @type atm :: {:atm, atom()}
  @type variable :: {:var, atom()}

  @type cons(e) :: {:cons, e, e}

  @type expr :: atm | variable | lambda | cons(expr)
  @type ignore :: :ignore

  @type pattern :: atm | variable | ignore | cons(pattern)

  @type id :: atom()
  @type str :: any()

  @type env :: [{id, str}]

  @type match :: {:match, pattern, expr}

  @type lambda :: {:lambda, [variable], [variable], seq}
  @type seq :: [expr] | [match | seq]
  @type closure :: {:closure, [variable], seq, env}

  #_______________ENVIROMENT______________
  @doc """
  Implementing an environment will be the simplest task that we have; an environment is simply a mapping from variables to data structures.
  If we assume that environments will be small, we can represent an environment as a list of key-value tuples.
  The environment {x/foo, y/bar} could be represented as: [{:x, :foo}, {:y, :bar}].
  The variables are represented by atoms, and we have here chosen to name them :x and :y but we could as well have chosen other atoms
  (x12, :variable_x) or integers (1 and 2), the important thing is that they all have unique names.
  """

  #Returns a new enviroment
  def new() do
    []
  end

  #Return an enviroment where the binding of the variable id to the structure str has been added to the enviroment
  def add(id,str,env) do
    [{id,str}|env]
  end

  #Looks for the id in the enviroment and it's binding
  #If the enviroment is empty then just return nil and finish
  def lookup(_,[]) do
    nil
  end

  #If we found the binding of id -> return the id togetther with it's binding
  def lookup(id,[{id,str}|t]) do
    {id,str}
  end

  #Look in the tail for the id
  def lookup(id,[_|t]) do
    lookup(id,t)
  end

  #Returns an enviroment where all bindings for variables in the list ids have been deleted
  def remove([],env) do
    env
  end

  #Iterates through the list
  def remove([id|rest],env) do
    remove(rest,delete(id,env))
  end

  #Returns a list without specified element
  def delete(_,[]) do
    []
  end

  #If we find the id, just move through it
  def delete(id,[{id,_}|rest]) do
    delete(id,rest)
  end

  #else -> Just add the header to the list
  def delete(id,[head|rest]) do
    [head|delete(id,rest)]
  end


end
