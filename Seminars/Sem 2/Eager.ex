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

    #The function will take a list of caluses, a datatstructure and an enviroment. It will
  #sslect the right caluse and continue the execution
  def eval_cls([], _, _, _) do
    :error
  end

  def eval_cls([{:clause, ptr, seq} | cls],str, env) do
    variables = extract_vars(ptr)
    env = Env.remove(variables,env)
    case eval_match(ptr,str,env) do
      :fail ->
        eval_cls(cls,str,env)

      {_,env} ->
        eval_seq(seq, env)
    end
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

  #Evaluate Case expression
  def eval_expr({:case, expr, cls},env) do
    case eval_expr(expr, env) do
      :error ->
        :error
      {_,str} ->
        eval_cls(cls,str,env)
    end
  end

  #We need to match a pattern with a data structure

  #If we have an atom and that atom is ok
  def eval_match({:atm,:a},:a,env) do
    {:ok,env}
  end

  def eval_match({:var,id},str,env) do
      case lookup(id,env) do
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

  def eval(seq) do
    eval_seq(seq,Env.new())
  end


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

#  @type pattern :: atm | variable | ignore | cons(pattern)

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

  def test() do
    seq = [{:match, {:var, :x}, {:atm, :a}},
       {:case, {:var, :x},
          [{:clause, {:atm, :b}, [{:atm, :ops}]},
           {:clause, {:atm, :a}, [{:atm, :yes}]}
          ]}
       ]

       eval_seq(seq,[])
  end

end
