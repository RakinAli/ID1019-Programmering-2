defmodule LZW do

  #All the alphabets allowed -> Play with this depending on the text
  @alphabet 'abcdefghijklmnopqrstuvwxyz '

  #Calls the alphabets and creates the table
  def table() do
    table(@alphabet)
  end

  # Creates a table
  def table(alphabet) do
    n = length(alphabet)

    #Turns words into list
    words = Enum.map(alphabet, fn x -> [x] end)

    #Converts all the numbers from 1 to n into a list
    codes = Enum.to_list(1..n)

    #Zips corresponding elements from each list in list_of_litsts.
    #Alltså -> [{a,1},{b,2}....{z,28} ] men obs att allra första elementen är length+1
    #-> Alltså {siffra, lista som innehåller tuplar{bokstav,siffra}}
    map = List.zip([words, codes])
    next = n + 1
    {next, map}
  end

  #Look up a code given a word
  def lookup_code({_, words}, word) do
    List.keyfind(words, word, 0)
  end

  #Look up a word using a code
  def lookup_word({_, words}, code) do
    List.keyfind(words, code, 1)
  end

  #Add a new word to the table; this is where we use the last code number
  #The new word becomes n+1. OBS Words = map = lista med bokstäverna

  def add({totalWords, words}, word) do
    IO.puts("Adding #{word} as code #{totalWords}")
    {totalWords+1, [{word, totalWords}|words]}
  end

  #If we have an emtpy list -> No alfabets then we throw an empry list
  def encode([], _) do
    []
  end

  #Else -> We encode it using a table
  def encode([char | rest], table) do

    #The word we want to encode becomes a list
    word = [char]

    #Pattern matching to encode the word
    {:found, code} = encode_word(word, table)

    #Now we encode rest of the words
    encode(rest, word, code, table)
  end

  #If there are no more characters in the text then we are done
  def encode([], _sofar, code, _table) do
    [code]
  end

  #If we have another character in the text we add this to the word we have read so-far and check
  #if this extended word can be found in the table. If we find a coding of the extended word we're happy but
  # we might be even hgappier if we find an even longer word. This is where we continue with the extendede word
  #and its code.
  def encode([char | rest], sofar, code, table) do
    extended = sofar ++ [char]
    case encode_word(extended, table) do
      {:found, ext} ->
        encode(rest, extended, ext, table)

      {:notfound, updated} ->
        sofar = [char]
        {_, cd} = encode_word(sofar, updated)
        [code | encode(rest, sofar, cd, updated)]
    end
  end

  #Encode the word
  def encode_word(word, table) do
    case lookup_code(table, word) do
      {_, code} ->
    ## if found we return the code
        {:found, code}
      nil ->
    ## otherwise we update the table
        {:notfound, add(table, word)}
    end
  end

  #Base case
  def decode([], _), do: []

  def decode([code], table) do
    ## this is the last code in the sequence
    {word, _code} = lookup_word(table, code)
    word
  end

  def decode([code | codes], table) do
    {word, _} = lookup_word(table, code)
    updated = decode_update(codes, word, table)
    word ++ decode(codes, updated)
  end

  def decode_update(next, word, table) do
    char = case lookup_word(table, next) do
         {found, _} ->
           hd(found)
         nil ->
               IO.puts("Could not find the code #{next}")
               hd(word)
       end
    add(table, word ++ [char])
  end

  #Taken straight from github
  # https://github.com/ID1019/functional-programming/blob/master/exercises/lzw/src/lzw.ex
  def test(), do: test('whatthefuck')

  def test(text) do
    IO.puts("The string of text: #{text}\n")

    IO.puts("\nThe plain string as charlist:")
    IO.inspect(text, charlists: :as_lists)
    IO.puts("\nLength of text: #{length(text)}")

    table = table(@alphabet)

    IO.puts("\nEncoding")
    encoded = encode(text, table)

    IO.puts("\nThe encoded string as charlist:")
    IO.inspect(encoded, charlists: :as_lists)
    IO.puts("\nLength of encoded: #{length(encoded)}\n")

    IO.puts("\nDecoding")
    decoded = decode(encoded, table)

    case decoded do
      ^text ->
        IO.puts("\nSUCCESS: The decoded message matches the original string!\n")
      _ ->
        IO.puts("\nERROR: The decoded message does NOT match the original string!\n")
    end
  end


end
