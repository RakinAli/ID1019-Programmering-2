defmodule Graph do
  @doc """
  The dynamic programming approach
  _________________________________
    * Find a recursive solution
    * Memorize solutions to subproblems
    *
  __________________________________
  If we are in the final node, the distance is zero and the path is

  Otherwise for each outgoing edge: find the shorest path from the reached
  node and return the shortest given the distance to the node

  If no path is found, we should return {:inf nil}

  How do we represent a graph
  -> As a list of edges
  {point1 , point2 , distance}, next edges osv
  [{:a,:b,2},{:a,:d,5},{:b,:c,2}....]:

  -> As a list of nodes
  [{:a[{:b,w},{:d,5}]},
    {b,[{:c,2},{e,3}]}

  ]

  -> As a matrix of edges
  """

  def sample() do
    new([a: [b: 2,d: 5],b: [c: 2]])
  end

  def new(nodes) do
    Map.new(nodes)
  end

  def next(from,map)do
    Map.get(map,from,[])
  end


  def shortest(from,from,_) do
    {0,[]}
  end

  def shortest(from,to,graph) do
    next = Graph.next(from,graph)
    distances = distances(next,to,graph)
    select(distances)
  end

  def distances(next,to,graph) do
    Enum.map(next,fn({n,d})->
      case shortest(n,to,graph) do
        #Path not possible? Nil
        {:inf,nil} -> {:inf,nil}
        #Path possible? plus d with k
        {k,path} -> {d+k,[n|path]}
      end
    end)
  end

  def select(distances) do
    List.foldl(distances,
    {:inf,nil},
    fn({d,_}=s,{ad,_}=acc) ->
      if d<ad do
        s
      else
        acc

      end
    end)
  end


end
