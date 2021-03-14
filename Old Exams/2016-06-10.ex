defmodule Q1 do

  #Creates a new car
  def new(id,brand,color) do
    {:car,id,brand,color}
  end

  #Returns the color of the color
  def color({:car,_,_,x}) do
    x
  end

  #Puts the new color on the car, current color not needed
  def paint(newColor,{:car,x,y,_}) do
    {:car,x,y,newColor}
  end

  #Test to create a car
  def test1() do
    new(2018,:bmw,:black)
  end

  #Test to get the color of the car
  def test2() do
    car =  {:car,2018,:bmw,:black}
    color(car)
  end

  #Test to paint the car
  def test3() do
    car =  {:car,2018,:bmw,:black}
    paint(:white,car)
  end
end

defmodule Q21 do

  #Calls a helper function
  def once(lst) do
    counter(lst,{0,0})
  end

  #Base case -> Just return the calculated sum and length
  def counter([],{sum,length}) do
    IO.puts("The sum is      -#{sum}")
    IO.puts("The length is   -#{length}")
    {sum,length}
  end

  #Runing case -> Just add them up
  def counter([h|t],{sum,length}) do
    counter(t,{sum+h,length+1})
  end

  def test() do
    once([1,2,3,4,5,6,7,8,9,10])
  end

end

defmodule Q22 do

  #Base case
  def ack(0,n) do
    n+1
  end

  #Another case
  def ack(m,0) when m>0 do
    ack(m-1,1)
  end

  #Running case
  def ack(m,n) when m>0 and n>0 do
    ack(m-1,ack(m,n-1))
  end

  def test() do
    ack(3,1)
  end

end

defmodule Q23 do

  def eval([]) do
    "Nothing to evaluate"
  end

  def eval([h|t]) do
    calculate(t,h)
  end

  def calculate([],sum) do
    sum
  end

  #If addittion
  def calculate(['+',number|rest],sum) do
    calculate(rest,sum+number)
  end

  #If subtraction
  def calculate(['-',number|rest],sum) do
    calculate(rest,sum-number)
  end

  def test() do
    list = [5, '+', 2, '-', 3, '+', 10]
    eval(list)
  end
end

defmodule Q24 do

  #Tree = {tree, Value,left,right}

  #If both are nil then we good
  def isomorfic(nil,nil) do
    true
  end

  #Running case -> Keep looking until they become nil
  def isomorfic({_,_,left1,right1},{_,_,left2,right2}) do
    case isomorfic(left1,left2) do
      true -> isomorfic(right1,right2)
      false -> false
    end
  end

  #
  def isomorfic(_,_) do
    false
  end
end

defmodule Q25 do

  def mirror(nil) do
    nil
  end

  #Just flips it around
  def mirror({tree,value,left,right}) do
    mirror({tree,value,mirror(right),mirror(left)})
  end

end

defmodule Q26 do

  #Tänk Algo:
  # 1) Den längst åt vänster i listan är element * n ^ listans.length-1 och lägg den i acc
  # 2) Fortsätt med tail

  def calc(lst,n) do
    calc(lst,n,0)
  end

  #Exit case -> Return the acc
  def calc([],_,acc) do
    acc
  end

  #Base case -> If we have variable is zero then just make it
  def calc(_,0,_) do
    0
  end

  #Running case
  def calc([h|t],n,acc) do
    #We get the power of here
    powerOF = length([h|t])-1

    #If the element isn't zero then we take element * n^(length of list-1)
    if h != 0 do
        calc(t,n,acc + h * :math.pow(n,powerOF))
    else
      calc(t,n,acc)
    end
  end

  def test() do

    list = [1,1,1,1,1,1,1,1,1]
    m = length(list)
    IO.puts("The length of the list is #{m}")
    calc(list,2)
  end
end

defmodule Q51 do

  def test() do
    process = spawn(fn->1+1 end)
    send(process,{:hi})
    send(process,{:whats})
    send(process,{:good})
    send(process,:done)
    collect()
  end

  def collect() do
    receive do
      :done -> []
      x -> [x|collect()]
    end

  end


end
