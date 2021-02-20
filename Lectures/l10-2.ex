defmodule DAG do
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

  def shortest(from,from,_) do
    {0,[]}
  end

  def shortest.from,to,graph) do
    next = Graph.next(from,graph)
    distances = distances(next,to,graph)
    select(distances)
  end




end
