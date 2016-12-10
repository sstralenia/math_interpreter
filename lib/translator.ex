defmodule MathInterpreter.Translator do
  alias MathInterpreter.Stack, as: Stack

  def translate_to_postfix_notation(tokens) do
    { :ok, pid } = Stack.start_link()
    _translate(tokens, [], pid)
  end

  defp _translate([ { :number, _ } = token | tail ], output, pid) do
    _translate(tail, [ token | output ], pid)
  end

  defp _translate([ :l_bracket = token | tail ], output, pid) do
    Stack.push(pid, token)
    _translate(tail, output, pid)
  end

  defp _translate([ :r_bracket | tail ] = string, output, pid) do
    top = Stack.pop(pid)

    case top do
      :l_bracket ->
        _translate(tail, output, pid)
      _ ->
        _translate(string, [ top | output ], pid)  
    end
  end

  defp _translate([ operator | tail ] = string, output, pid) do
    top = Stack.peek(pid)

    case top do
      nil ->
        Stack.push(pid, operator)
        _translate(tail, output, pid)
      _ ->
        if priority(operator) <= priority(top) do
          Stack.pop(pid)
          _translate(string, [top | output], pid)
        else
          Stack.push(pid, operator)
          _translate(tail, output, pid)
        end   
    end
  end

  defp _translate([], output, pid) do
    top = Stack.peek(pid)

    case top do
      nil ->
        Enum.reverse(output)
      _ ->
        Stack.pop(pid)
        _translate([], [ top | output ], pid)
    end
  end

  def priority(:l_bracket), do: 1
  def priority(:r_bracket), do: 1
  def priority(:plus), do: 2
  def priority(:minus), do: 2
  def priority(:mul), do: 3
  def priority(:div), do: 3
  def priority(:pow), do: 4
end

