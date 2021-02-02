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

  #Base case ->Returns the tree if the tail is empty
  def tree() do
    huffman_tree(testSort())
  end

  def huffman_tree([{tree,_}]) do
    tree
  end

  #
  def huffman_tree([{a,afrek},{b,bfrek}|tail]) do
    huffman_tree(insert({{a,b},afrek+bfrek},tail))
  end

  def insert({a,af},[]) do
    [{a,af}]
  end

  def insert({a,afrek},[{b,bfrek}|tail]) when afrek<bfrek do
    [{a,afrek},{b,bfrek}|tail]
  end

  def insert({a,afrek},[{b,bfrek}|tail]) do
    [{b,bfrek}| insert({a,afrek},tail)]
  end

  def testTree do
    huffman_tree(testSort())
  end

  #__________Encoding the Tree__________

  #This used for encoding table -> Puts every char in binary
  def table(tree) do
    traverse(tree,[],[])
  end

  #Traverses through the tree. Code is the binary form
  #Table is the entire list.
  def traverse({left,right},code,table) do
    leftside = traverse(left,[0|code],table)

    #We are updating the table
    traverse(right,[1|code],leftside)
  end

  #Puts it as a {char,[code - 100001]}
  def traverse(char,code,table) do
    [{char,code}|table]
  end

  

  def lookup(char,[{_,_}|rest]) do
    lookup(char,rest)
  end

  #Cannot encode an empty list
  def encode([],_) do
    []
  end

  #Returns the value of bits
  def encode([char|rest],table) do
    lookup(char,table) ++ encode(rest,table)
  end
#__________________________________________________#

#__________________Decode___________________________

  def decode([],_) do
    []
  end

  #Uses the table to decode the encoded message
  def decode(seq,table) do
    {char,rest} = decode_char(seq,1,table)
    [char|decode(rest,table)]
  end

  def decode_char(seq,n,table) do
    {code,rest} = Enum.split(seq,n)
    case charFinder(table,code)do
      {char,_} -> {char,rest}
      nil -> decode_char(seq,n+1,table)
    end
  end

  #Empty list entered -> Cannot do anything
  def charFinder([],_) do
    nil
  end

  #If the encoded code matches the char in the table
  def charFinder([{char,code}|_],code) do
    {char,code}
  end


  def charFinder([_,rest],code) do
    charFinder(rest,code)
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
