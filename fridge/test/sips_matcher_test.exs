defmodule SipsMatcher do
  use GenFSM.Behaviour

  # Public API
  def start_link do
    {:ok, fsm} = :gen_fsm.start_link(__MODULE__, [], [])
    fsm
  end

  def consume_s(fsm) do
    :gen_fsm.sync_send_event(fsm, :s)
  end

  def consume_not_s(fsm) do
    :gen_fsm.sync_send_event(fsm, :not_s)
  end

  # GenFSM API
  def init(_) do
    {:ok, :starting, []}
  end

  def starting(:s, _from, state) do
    {:reply, :got_s, :got_s, state}
  end

  def starting(:not_s, _from, state) do
    {:reply, :starting, :starting, state}
  end
end

defmodule SipsMatcherTest do
  use ExUnit.Case

  test "[:starting] it sucessfully consumes the string 's'" do
    fsm = SipsMatcher.start_link
    assert SipsMatcher.consume_s(fsm) == :got_s
  end

  test "[:starting] it sucessfully consumes the strings other than 's'" do
    fsm = SipsMatcher.start_link
    assert SipsMatcher.consume_not_s(fsm) == :starting
  end
end
