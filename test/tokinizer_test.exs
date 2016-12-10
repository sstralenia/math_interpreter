defmodule TokenizerTest do
	use ExUnit.Case, async: true
  import MathInterpreter.Tokenizer  

  test "13 + 2" do
    assert tokenize('13 + 2') == [{ :number, 13 }, :plus, { :number, 2 }]
  end

  test "10 -(5 * 8)^2" do
    assert tokenize('10 - (5 * 8)^2') == [
      { :number, 10 }, :minus, :l_bracket, { :number, 5 }, :mul,
      { :number, 8 }, :r_bracket, :pow, { :number, 2 }
    ]
  end

  test "(5/6 + 1^2) - 1" do
    assert tokenize('(5/6 + 1^2) - 1') == [
      :l_bracket, { :number, 5 }, :div, { :number, 6 }, :plus,
      { :number, 1 }, :pow, { :number, 2 }, :r_bracket, :minus, { :number, 1 }
    ] 
  end

  test "3 + 4 * 2 / (1 - 5)^2" do
    assert tokenize('3 + 4 * 2 / (1 - 5)^2') == [
      { :number, 3 }, :plus, { :number, 4 }, :mul, { :number, 2 }, :div,
      :l_bracket, { :number, 1 }, :minus, { :number, 5 }, :r_bracket, :pow,
      { :number, 2 }
    ]
  end
end

