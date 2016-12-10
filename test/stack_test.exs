defmodule StackTest do
  use ExUnit.Case
  alias MathInterpreter.Stack, as: Stack

  setup do
    { :ok, pid } = Stack.start_link()
    { :ok, [pid: pid] }
  end

  test "push", context do
    pid = context[:pid]

    assert Stack.peek(pid) == nil

    :ok = Stack.push(pid, 1)
    assert Stack.peek(pid) == 1

    :ok = Stack.push(pid, 2)
    :ok = Stack.push(pid, 3)
    assert Stack.peek(pid) == 3
  end

  test "pop", context do
    pid = context[:pid]

    assert Stack.peek(pid) == nil

    :ok = Stack.push(pid, 1)
    assert Stack.pop(pid) == 1
    assert Stack.peek(pid) == nil

    :ok = Stack.push(pid, 2)
    :ok = Stack.push(pid, 3)
    assert Stack.pop(pid) == 3
    assert Stack.peek(pid) == 2
  end
end