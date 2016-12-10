defmodule MathInterpreter.Stack do
  use GenServer

  def start_link() do
    { :ok, _pid } = GenServer.start_link(__MODULE__, [])
  end

  def push(pid, value) do
    GenServer.cast(pid, { :push, value })
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def peek(pid) do
    GenServer.call(pid, :peek)
  end

  def handle_call(:pop, _, []), do: { :reply, nil, [] }
  def handle_call(:pop, _, [ top | tail ]), do: { :reply, top, tail }

  def handle_call(:peek, _, []), do: { :reply, nil, [] }
  def handle_call(:peek, _, [ top | _ ] = state), do: { :reply, top, state }

  def handle_cast({ :push, value }, state), do: { :noreply, [ value | state ] }
end
