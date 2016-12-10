defmodule TranslatorTest do
	use ExUnit.Case, async: true
	import MathInterpreter.Translator

	test "13 + 2" do
    assert translate_to_postfix_notation([
      { :number, 13 }, :plus, { :number, 2 }
    ]) == [
			{ :number, 13 }, { :number, 2 }, :plus
		]
  end

  test "10 -(5 * 8)^2" do
    assert translate_to_postfix_notation([
      { :number, 10 }, :minus, :l_bracket, { :number, 5 }, :mul,
      { :number, 8 }, :r_bracket, :pow, { :number, 2 }
    ]) == [
  		{ :number, 10 }, { :number, 5}, { :number, 8 }, :mul, { :number, 2}, :pow,
      :minus     
		]
  end

  test "(5/6 + 1^2) - 1" do
    assert translate_to_postfix_notation([
      :l_bracket, { :number, 5 }, :div, { :number, 6 }, :plus,
      { :number, 1 }, :pow, { :number, 2 }, :r_bracket, :minus, { :number, 1 }
    ]) == [
    	{ :number, 5 }, { :number, 6}, :div, { :number, 1}, { :number, 2 }, :pow,
      :plus, { :number, 1}, :minus    
		] 
  end

  test "3 + 4 * 2 / (1 - 5)^2" do
    assert translate_to_postfix_notation([{ :number, 3 }, :plus, { :number, 4 },
      :mul, { :number, 2 }, :div, :l_bracket, { :number, 1 }, :minus,
      { :number, 5 }, :r_bracket, :pow, { :number, 2 }
    ]) == [
    	{ :number, 3 }, { :number, 4 }, { :number, 2 }, :mul, { :number, 1 },
      { :number, 5 }, :minus, { :number, 2 }, :pow, :div, :plus
    ]
  end
end

