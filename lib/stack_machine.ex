defmodule MathInterpreter.StackMachine do
	alias MathInterpreter.Stack, as: Stack

	def evaluate(expression) do
		{ :ok, pid } = Stack.start_link()
		 _evaluate(expression, pid)
	end

  defp _evaluate([], pid), do: Stack.pop(pid)

  defp _evaluate([ { :number, number } | tail ], pid) do
		Stack.push(pid, number)
    _evaluate(tail, pid)
  end

  defp _evaluate([ operator | tail ], pid) do
		number1 = Stack.pop(pid)
		number2 = Stack.pop(pid)
    result = apply_operator(operator, number1, number2)
    
		Stack.push(pid, result)
		_evaluate(tail, pid)
  end

  defp apply_operator(:plus, num1, num2), do: num2 + num1
  defp apply_operator(:minus, num1, num2), do: num2 - num1
  defp apply_operator(:mul, num1, num2), do: num2 * num1
  defp apply_operator(:div, num1, num2), do: num2 / num1
  defp apply_operator(:pow, num1, num2), do: :math.pow(num2, num1)
end

