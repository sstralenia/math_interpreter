defmodule StackMachineTest do
	use ExUnit.Case, async: true
  import MathInterpreter.StackMachine

	test "13 + 2" do
    assert evaluate( [
			{ :number, 13 }, { :number, 2 }, :plus
		]) == 15
  end

  test "10 -(5 * 8)^2" do
    assert evaluate([
  		{ :number, 10 }, { :number, 5}, { :number, 8 }, :mul, { :number, 2}, :pow,
      :minus     
		]) == -1590
  end

  test "(12/6 + 1^2) - 1" do
    assert evaluate([
    	{ :number, 12 }, { :number, 6}, :div, { :number, 1}, { :number, 2 }, :pow,
      :plus, { :number, 1}, :minus    
		]) == 2
  end

  test "3 + 4 * 2 / (1 - 5)^2" do
    assert evaluate([
    	{ :number, 3 }, { :number, 4 }, { :number, 2 }, :mul, { :number, 1 },
      { :number, 5 }, :minus, { :number, 2 }, :pow, :div, :plus
    ]) == 3.5
  end
end

