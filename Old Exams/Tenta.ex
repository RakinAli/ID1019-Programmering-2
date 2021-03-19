defmodule Q1 do

  # -> We represent
  # -> We represent registers as a tuple,
  # -> We represent code as a {:instruction,registers}
  # -> Programcount as a number which we increment per instruction
  #-> Represent code segment as a list


  @code {   {:addi, 1, 0, 10},
            {:addi, 3, 0 ,1},
            {:out, 3},
            {:addi, 1, 1, -1},
            {:addi, 4, 3, 0},
            {:add, 3, 2, 3},
            {:out, 3},
            {:beq, 1, 0, 3},
            {:addi, 2, 4, 0},
            {:beq, 0, 0, -6},
            {:halt}
        }

  ########### INSTRUCTIONS ###############

  #Creates a register -> Returns a tuple
  def registers() do
    {0,0,0,0,0,0}
  end

  #Addi instructions -> Returns an updated list of tuples
  def addi(regDst,reg1,imm,tuple) do
    reg1 = elem(tuple,reg1)
    updateValue = reg1 + imm
    put_elem(tuple,regDst,updateValue)
  end

  #Does addition -> Returns an updated list of tuples
  def add(regdst,reg2,reg3,tuple) do
    value1 = elem(tuple,reg2)
    value2 = elem(tuple,reg3)
    put_elem(tuple,regdst,value1+value2)
  end

  #Compares two registers -> Return an updated pc, NOT A TUPLES
  def beq(reg1,reg2,offset,regtuple,pc) do
    compare1 = elem(regtuple,reg1)
    compare2 = elem(regtuple,reg2)
    #Returns an integer -> the updated PC value
    if compare1 == compare2 do
      pc + offset
    else
      pc + 1
    end
  end

  #Handles out -> Returns list
  def out(regNumber,regtuples,acc) do
    regOut = elem(regtuples,regNumber)
    acc ++[regOut]
  end

  #################### MAIN ##################

  #Runs the code -> The main
  def coder(pc,@code,regtuple,outer) do
    instruction = elem(@code,pc)

    case instruction do
      #Handles addi
      {:addi,regDst,reg1,imm} ->
        uppdatedReg = addi(regDst,reg1,imm,regtuple)
        coder(pc+1,@code,uppdatedReg,outer)

      #Handles add
      {:add,regDst,reg1,reg2} ->
        updatedReg = add(regDst,reg1,reg2,regtuple)
        coder(pc+1,@code,updatedReg,outer)

      #Handles beq instruction
      {:beq,reg1,reg2,offset} ->
        newPC = beq(reg1,reg2,offset,regtuple,pc)
        coder(newPC,@code,regtuple,outer)

      #Handles out instruciton
        {:out,regnumber} ->
          newList= out(regnumber,regtuple,outer)
          coder(pc+1,@code,regtuple,newList)

      #Handles halt
        {:halt} ->
          outer
    end
  end

  #Try this to test code
  def test() do
    #Här testade jag min kod
  end

end
