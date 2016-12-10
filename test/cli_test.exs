defmodule CliTest do
	use ExUnit.Case, async: true
  import MathInterpreter.CLI, only: [parse_args: 1]

	test "help" do
		assert parse_args(["-h", "something"]) == :help
		assert parse_args(["--help", "something"]) == :help
	end

	test "eval" do
		assert parse_args(["2 + 3- (3 -8)^2"]) == "2 + 3- (3 -8)^2"
	end

	test "error" do
		assert parse_args(["-w", "unknown flag"]) == :error
	end
end

