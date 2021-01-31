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

  #Base case -> Return the filled in list
  def freq([], frequencyList) do
    frequencyList
  end

  #Oftan case -> Just iterate through the char list
  def freq([char|rest],frequencyList) do
    freq(rest,count(char,frequencyList))
  end

  #A sample text
  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  #Test freq function
  def testFreq do
    sample = sample()
    freq(sample)
  end

  #__________Quick SORT__________ -> Used to fixed Freq list
   #Empty list to sort
   def qsort([]) do
    []
  end

  #Sorts on the way down
  def qsort([{char,freq}|list]) do
    {small,large} = qsplit({char,freq},list,[],[])
    small = qsort(small)
    large = qsort(large)
    append(small,[{char,freq}|large])
  end

  #Cannot split an empty list
  def qsplit(_,[],small,large) do
    {small,large}
  end

  #One list gets broken into two lists If smaller than privot then small else large list
  def qsplit({char1,freq},[{char2,freq2}|t],small,large) do
    if freq > freq2 do
      qsplit({char1,freq},t,[{char2,freq2}|small],large)
    else
      qsplit({char1,freq},t,small,[{char2,freq2}|large])
    end
  end

  # Nothing to do
  def append([],[]) do
    []
  end

  #Adds an element to the list
  def append(element,[])do
    [element]
  end

  #Flattens two lists
  def append(small,large) do
    small ++ large
  end

  def testSort do
    qsort(testFreq())
  end

  #___________TREE BUILDING__________
  #{:leaf,char} -> Leaf
  #{:node,value,left,right} -> Node

  #{char,freq} -> how an element is represented
  # Insertion function asummes that the freq list thrown in is sorted by frequency

  #First case -> Building the tree
  def insert([h|t]) do
    insert([h|t],:nil)
  end

  #Starting case ->The first inserted element becomes a leaf
  def insert([h|t],:nil) do
    insert(t,{:leaf,h})
  end

  #Base case
  def insert([],tree) do
    tree
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
