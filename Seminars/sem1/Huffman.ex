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

  #___________TREE BUILDING__________
  #{:leaf,char} -> Leaf
  #{:node,value,left,right} -> Node

  #{char,freq} -> how an element is represented
  # Insertion function asummes that the freq list thrown in is sorted by frequency

  #Base case ->Returns the tree if the tail is empty
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

  #__________Encoding the Tree__________

  #This used for encoding table -> Puts every char in binary
  def encode_table(tree) do
    traverse(tree,[],[])
  end

  #Traverses through the tree. Code is the binary form
  #Table is the entire list.
  def traverse({left,right},code,table) do
    leftside = traverse(left,[0|code],table)

    #We are updating the table
    traverse(right,[1|code],leftside)
  end

  #It will look likes this -> {char,[code - 100001]}
  def traverse(char,code,table) do
    [{char,reverse(code)}|table]
  end

  #Reverse function for code -> This is needed because t = 001 becomes 100 ty reverse

  def reverse(rev) do
    reverse(rev,[])
  end

  def reverse([],rev) do
    rev
  end

  def reverse([h|t],rev)do
    reverse(t,[h|rev])
  end

  #Function lookup checks the table and looks for the element

  #looks up in the table
  def lookup(_,[]) do
    []
  end

  #Returns the Binary code of the char according to the tree
  def lookup(char,[{char,code}|_]) do
    code
  end

  #Looks for the char in the rest
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

  #Decode table used to find characters
  def decode_table(tree) do
    traverse(tree,[],[])
  end

  #Base case -> Nothing to decode
  def decode([],_) do
    []
  end

  def decode(binary,table) do
    #We
    {char,rest} = decode_char(binary,1,table)
    [char|decode(rest,table)]
  end

  def decode_char(binary,n,table) do
    {code,rest} = Enum.split(binary,n)
    case charFind(table,code) do
      {char,_} -> {char,rest}
      nil -> decode_char(binary,n+1,table)
    end
  end

  #charFinder looks for the character

  #Empty t
  def charFind([],_) do
    nil
  end


  #the Table has found the code -> Return the code
  def charFind([{char,code}|_],code) do
    {char,code}
  end

   #Else continue looking in the rest
   def charFind([_|rest],code) do
    charFind(rest,code)
  end

  #_____Dummy block_____


  def text() do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def test() do
    #Takes in a text
    sample = text()

    #Finds out the freq of the characters then sorts them based on freq
    samplee = qsort(freq(sample))

    #Creates a huffman tree based on their freq. shorter branches -> less freq
    tree = huffman_tree(samplee)

    #The table used to encode each character
    table = encode_table(tree)

    #Decodes the text into Binary using the text and encoding table
    binaryCode = encode(sample,table)

    #Decodes the Binary text using the binary and the table
    decode(binaryCode,table)
  end

end
