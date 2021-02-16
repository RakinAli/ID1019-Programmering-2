defmodule Car do
  #Typsystem


  @spec fib(integer()) :: integer()
  def fib(0) do
    0
  end

  def fib(1) do
    1
  end

  def fib(n) do
    fib(n-1) + fib(n-2)
  end

  #Cards are represented as {:card,suit,value} where the suit is represented using
  #the atoms :spade, :heart, :diamond and :cluns. How do we specify the type for suit?

  #Use @type to defici types and values osv,
  #@type value() :: 1..3 -> Means a card has value 1 to 13
  #@type suit():: spade|:heart|:diamond|:clybs
  #@card() :: {}
  #type number() :: integer()|float

  #@type any() -> Alla möjliga tpyes.

  @doc """
  @type list(t) :: [] |[t|list(t)]
  @type string():: list(char())
  Type specifiers are used for
  * documentation of intended usage
  * Automatic detection of type error
  the compiler does not check types

  Dialyzer
  * Checks that given specifications agree with call patterns
  * Detecks exceptions and dead code
  - > Hard to get going

  Elixir is a dynamically typed langage: Types are checked and handled ar run time. Other dynamically
  langauges PHP, Pyton, Erlang, Lisp and Prolog

  Java is statically typed langauged: types are checked and handled at compile run, other statically
  language typed language.

  """

  #Namngiven map. Syntax är likt maps
  defstruct brand: "", year: :na, model: "unknown", cyl: :na, power: :na

  def year(car = %Car{}) do
    car.year
  end

  def a4() do
    %Car{:brand => "Saab", :model => "96 V4", :year => 1974, :power => 65, :cyl => 4}
  end

  def a1() do
    {:car,"Volvo",
    {:model,"XC60",2018},
      {:color,"blue"},
      {:engine, "A4",4,200,120},
      {:perf,4,6,8.8}
    }
  end

  def a2() do
    {
      :car,"VW",
      [{:model,"Typ-1"},{:year,1964},{:engine,"1300"},
      {:cyl,4},{:vol,1300},{:color, "blue"},{:power,40},
      {:fuel,4.6},{:acc,12.8}]
    }
  end


  def car_brand_model_1( {:car,brand, {:model,model,_},_,_,_}) do
    "#{brand} #{model}"
  end

  def car_brand_model_2({:car,brand,prop}) do
    case List.keyfind(prop,:model,0) do
      nil ->
        brand
      {:model,model} ->
        "#{brand},#{model}"
    end
  end

  def car_brand_model_3({:car,brand,prop}) do
    case prop do
      %{:model => model} ->
        "#{brand} #{model}"
      _ ->
        brand
    end
  end
end


#Learn maps. Makes everything easier but doesn't mean they are efficient.
defmodule Dog do
  defstruct name: "Fido", year: 2020

  def karo() do
    %Dog{name: "Karo"}
  end
end
