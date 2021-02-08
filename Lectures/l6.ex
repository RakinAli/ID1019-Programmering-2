defmodule Test do

  #Lecture notes ->

  # a domain:Z
  # a set of primitive functions: +, -, *, mod, div
  # Syntex: symbols, precedence, parantheese ie a way to write expressions

  # (3+5) * (6-3) rewrite this
  # A evulation of expressions

  #A function that is defined to be falsum if any of its arguments is falsum
  # is called a strict function. All of our regular functions are
  #stricts functions

  # We need to be careful when evaluating expressions.

  # If all functions are strict: -> Then all arguments of the functions must be evuluated
  # Assume we have a function if(test, then, else) with the obvious defintion
  # -> we can use it to represent falseum osv

  #To make life more interesting we introduce
  #Variables: x, y etc
  # and fucntions: :lamba x -> x + 5

  #In the literature we write lamdax.x+5 but we will use ->
  #So far, functions do not have names
  #lamba x -> x+5
  #fnx -> x+5 end in interactive elixir

  #We apply a function to an argument(or actual arguments)
  #(lamda x -> (E)7)
  # By substituing the paramenter of the function with the arguemnt
  # [x/7]E where E is expression
  # A substituion is possible even if doesnt have any free variables
  # Alonzo Church invented this shit

  # Only three types of expressions: variable, lambda abstraction and apllication
  # Only one rule: Evalution of application
  #  You don't even need data structures nor named functions
  # Anything that is computable can be expressed in lambda calculus, it is as powerful as Turing machine
  # We will use some extensions to the language when we decribe functional programming

  #A function of two arugments can be described as function of one argument that evalutates
  # to another function of a second argument

  #Functional programming -> made in lambda calculus but not the best syntaxes

  #We will define a small subet of the Elixir langauge and describe the operational semantics
  # Warning -> This is now how exilixr works but could be
  #The language is described using a BNF notation
  #<atom> ::== :a,|

  #____________________________________







end
