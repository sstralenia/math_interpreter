defmodule MathInterpreter.Tokenizer do
  def tokenize(string) do
    string
    |> _tokenize([])
    |> Enum.reverse
  end

  defp _tokenize([], acc), do: acc
  defp _tokenize([ head | tail ] = string, acc) do
    case _token(head) do
      :digit ->
        digit = head - ?0
        case acc do
				  [ { :number, num } | acc_tail ] -> 
            _tokenize(tail, [ { :number, num * 10 + digit } | acc_tail ])
          _ ->  
            _tokenize(tail, [ { :number, digit } | acc ])
        end
      :space -> _tokenize(tail, acc)
      token -> _tokenize(tail, [token | acc])
    end
  end

  defp _token(?(), do: :l_bracket
  defp _token(?)), do: :r_bracket
  defp _token(?+), do: :plus
  defp _token(?-), do: :minus
  defp _token(?*), do: :mul
  defp _token(?/), do: :div
  defp _token(?^), do: :pow
  defp _token(?\s), do: :space
  defp _token(char) when char in '0123456789', do: :digit
  defp _token(char), do: throw "Unexpected character #{char}"
end
