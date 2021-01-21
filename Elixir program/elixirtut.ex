defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    list1 = [1,2,3]
    list2 = [4,5,6]

    list3 = list1 ++list2

    list4 = list3 -- list1

    IO.puts 6 in list4

    [head | tail] = list3
    IO.puts "Head : #{head}"

    IO.write "Tail :"
    IO.inspect tail
    IO.inspect [97,98], char_lists: :as_lists

    Enum.each tail, fn item ->
      IO.puts item
    end

    words = ["Random", "Words","in a ","List"]
    Enum.each words, fn word ->
      IO.puts word
    end

    display_list(words)
  end

  def display_list([word|words]) do
    IO.puts word
    display_list(words)
  end

  def display_list([]), do: nil

end
