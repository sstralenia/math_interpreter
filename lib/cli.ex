defmodule MathInterpreter.CLI do
	import MathInterpreter.Tokenizer, only: [tokenize: 1]
	import MathInterpreter.Translator, only: [translate_to_postfix_notation: 1]
	import MathInterpreter.StackMachine, only: [evaluate: 1]

	def main(argv) do
		argv
		|> parse_args
		|> process
	end
	
	def parse_args(args) do
		parse = OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help]) 
		
		case parse do
			{ [help: true], _, _ } -> :help
			{ _, [string_to_evaluate], _ } -> string_to_evaluate
			_ -> :error 
		end
	end

	def process(:help) do
	  IO.puts "usage: math_intepreter 'expression'"
		System.halt(0)
	end

	def process(:error) do
		IO.puts "Something went wrong"
		System.halt(0)
	end

	def process(string_to_evaluate) do
		string_to_evaluate
		|> String.to_char_list
		|> tokenize
		|> translate_to_postfix_notation
		|> evaluate
		|> IO.puts
	end
end

