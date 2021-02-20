defmodule Hinges do

  @doc """
  Assume we make h hinges and l latches
  * Limited resources* 260h + 180l < 2400
  * Limited time: 40h + 60i < 480
  * Profit: p = 30 h + 24i
  * Find h and i to maximize p

  Describe a product as {material, time, prize}:
  hinge is {240,40,30}
  latch is {180,60,24}

  Define a function serach(material,time,hinge,latch) that given the parameteres returns
  the number of hinges h and latches l to produce maximize profit


  """

  def search(m,t,{hm,ht,hp}=h,{lm,lt,lp}=l) when
  (m>=hm) and (t>= ht) and (m >= lm) and (t >= lt) do

    #We have material and lime to make either a hinge or latch
    {hi,li,pi} = search((m-hm),(t-ht),h,l)
    {hj,lj,pj} = search((m-lm),(t-lt),h,l)

    #Which alternative will give us the maxiumum profit
    if((pi+hp)>(pj+lp))do
      #Make hinge
      {(hi+1),li,(pi+hp)}
    else
      #Make a latch
      {hj,(lj+1),(pj+lp)}
    end
  end

  #Base case
  def search(m,t,{hm,ht,hp}=h,l) when (m>=hm) and (t >= ht) do
    #We can make a hinge
    {hn,ln,p} = search((m-hm),(t-ht),h,l)
    {hn+1,ln,(p+hp)}
  end

  #Special case
  def search(m,t,h,{lm,lt,lp}=l) when (m>= lm) and (t>=lt) do
    #We can make a latch
    {hn,ln,p} = search((m-lm),(t-lt),h,l)
    {hn,ln+1,p+lp}
  end

  def search(_,_,_,_) do
    #We can make neither
    {0,0,0}
  end

  #Fine the memory time
  def memory(material,time,hinge,latch) do
    mem = Memory.new()
    {solution,_} = search(material,time,hinge,latch,mem)
    solution
  end

  def check(material,time,hinge,latch,mem) do
    case Memory.lookup({material,time},mem)do
      nil ->
        #No previous solution found
        {solution,mem} = search(material,time,hinge,latch,mem)
        {solution,Memory.store({material,time},solution,mem)}

      found ->
        {found,mem}
    end
  end
end

#The key is a tuple{m,t} defining the remaining source
#The value is the number of hinges and latches and best profit possible at this point


defmodule Memory do

  def new() do
    []
  end

  def store(k,v,mem) do
    [{k,v|mem}]
  end

  def lookup(_,[]) do
    nil
  end

  def lookup(k,[{k,v}|_])do
    v
  end

  def lookup(k,[_|rest]) do
    lookup(k,rest)
  end
end

