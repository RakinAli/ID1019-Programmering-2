defmodule Morse do

  #A test function
  def test() do
    signal = '... --- ...'
    decode(signal)
  end

  #Start case. Brings the table
  def decode(signal) do
    table = decode_table()
    decode(signal, table)
  end


  #No table then do nothing
  def decode([], _) do
    []
  end

  #Running case
  def decode(signal, table) do
    {char,rest}  = decode_char(signal, table)
    [char | decode(rest, table)]
  end


  #Special case -> Found the char
  def decode_char([], {:node, char, _, _}) do
    {char,[]}
  end

  #if I see a long -> Go to the long branch
  def decode_char([?- | signal], {:node, _, long, _}) do
    decode_char(signal,long)
  end

  #If I see a . then go to "short"
  def decode_char([?. | signal], {:node, _, _, short}) do
    decode_char(signal,short)
  end

  #Found the space
  def decode_char([?\s | signal], {:node, char, _, _}) do
    {char,signal}
  end


  # Some test samples to decode, a signal must end with a space ' '
  def base(), do: '.- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ...'

  def rolled(), do: '.... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .----'

  # Morse decoding tree as {:node, char, long, short}
  defp decode_table do
    {:node, :na,
      {:node, 116,
        {:node, 109,
          {:node, 111,
            {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
            {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
          {:node, 103,
            {:node, 113, nil, nil},
            {:node, 122,
              {:node, :na, {:node, 44, nil, nil}, nil},
              {:node, 55, nil, nil}}}},
        {:node, 110,
          {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
          {:node, 100,
            {:node, 120, nil, nil},
            {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
      {:node, 101,
        {:node, 97,
          {:node, 119,
            {:node, 106,
              {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
              nil},
            {:node, 112,
              {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
              nil}},
          {:node, 114,
            {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
            {:node, 108, nil, nil}}},
        {:node, 105,
          {:node, 117,
            {:node, 32,
              {:node, 50, nil, nil},
              {:node, :na, nil, {:node, 63, nil, nil}}},
            {:node, 102, nil, nil}},
          {:node, 115,
            {:node, 118, {:node, 51, nil, nil}, nil},
            {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
  end

end
