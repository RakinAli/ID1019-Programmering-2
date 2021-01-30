defmodule Huffman do


  #_____ Count function _____


  #Base case->if it has not the char
  def count(char,[]) do
    [{char,1}]
  end

  #Case 1 -> If it has found the char
  def count(char,[{char,n}|t]) do
    [{char,n+1}|t]
  end

  #Running case -> Iterates through the list
  def count(char,[h|t]) do
    [h|count(char,t)]
  end


  #_____Frequency_____

  #Calling case
  def freq(sample) do
    freq(sample,[])
  end

  #Base case - Return the filled in list
  def freq([], frequencyList) do
    frequencyList
  end

  
  def freq([char|rest],frequencyList) do
    freq(rest,count(char,frequencyList))
  end

  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def test do
    sample = sample()
    freq(sample)
  end

  #_____Dummy block_____
  @doc """

  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text() do
    'this is something that we should encode'
  end

  def test() do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end

  def tree(sample)do
    freq = freq(sample)
    huffman(freq)
  end

  def encode_table(tree)do
    #To implemeent
  end

  def decode_table(tree) do
    #To implement
  end

  def encode(text,table)do
    #To implement
  end

  def decode(seq,tree) do
    #To implement
  end
  """

end
