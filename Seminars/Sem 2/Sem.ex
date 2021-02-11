defmodule Env do

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
  def lookup(id,[{id,str}|_]) do
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

  #We need to match a pattern with a data structure

  #If we have an atom and that atom is ok
  def eval_match({:atm,:a},:a,env) do
    {:ok,env}
  end

  def eval_match({:var,id},str,env) do
      case Env.lookup(id,env) do
        #Case 1 -> Variable is not in the enviroment
        nil ->
          [{id,str}|env]
        #Case 2 -> Variable already has binded to str in enviroment
        {_,^str} ->
          {:ok,env}
        #Case 3 -> Variable is binded to something else, not str
        {_,_} ->
          :fail
      end
  end

  def eval_match({:cons,var1,var2},[atm1|atm2],env) do
    case eval_match(var1,atm1,env) do
      :fail ->
        :fail
      {:ok,env} ->
        eval_match(var2,atm2,env)
    end
  end

  #If we cannot match it to any datastructure then fail it
  def eval_match(_,_,_) do
    :fail
  end

  #Initialize sequence
  def eval(seq) do
    eval_seq(seq,Env.new())
  end

  #Evulate the expresision
  def eval_seq([exp], env) do
    eval_expr(exp,env)
  end


  def eval_seq([{:match,pattern, expression} | rest], env) do
    #Evalutate expression ->
    case eval_expr(expression,env) do
      #If not correct expression give error
      :error->
        :error
      #Else take out the binding
      {:ok,binding} ->
        #We now want to remove the variable but not what it's binded to
        vars = extract_vars(pattern)
        enviroment = Env.remove(vars,env)

        #Look if binding is inside pattern
        case eval_match(pattern,binding,enviroment) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(rest,env)
        end
    end
  end

  # @type pattern :: atm | variable | ignore | cons(pattern)

  #Extract funtion returns a list of all variables in a pattern
  def extract_vars({:var,var}) do
    [var]
  end

  #Extract both of the patterns in a cons cell
  def extract_vars({:cons,p1,p2}) do
    extract_vars(p1) ++ extract_vars(p2)
  end

  #If there's an ignote then do noththing
  def extract_vars(_) do
    []
  end

end
