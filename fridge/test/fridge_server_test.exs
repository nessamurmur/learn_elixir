defmodule FridgeServer do
  use GenServer.Behaviour

  # Public API
  def start_link(items\\[]) do
    {:ok, fridge} = :gen_server.start_link( __MODULE__, [], items)
    fridge
  end

  def store(fridge, item) do
    :gen_server.call(fridge, {:store, item})
  end

  def take(fridge, item) do
    :gen_server.call(fridge, {:take, item})
  end

  # Genserver API
  def init(items) do
    {:ok, items}
  end

  def handle_call({:store, item}, _from, items) do
    {:reply, :ok, [item|items]}
  end

  def handle_call({:take, item}, _from, items) do
    case Enum.member?(items, item) do
      true ->
        {:reply, {:ok, item}, List.delete(items, item)}
      false ->
        {:reply, :not_found, items}
    end
  end
end

defmodule FridgeServerTest do
  use ExUnit.Case

  test "putting something into a fridge" do
    fridge = FridgeServer.start_link
    assert :ok == FridgeServer.store(fridge, :bacon)
  end

  test "removing something from the fridge" do
    fridge = FridgeServer.start_link
    FridgeServer.store(fridge, :bacon)
    assert {:ok, :bacon} == FridgeServer.take(fridge, :bacon)
  end

  test "removing something from the fridge that isn't there" do
    fridge = FridgeServer.start_link
    assert :not_found == FridgeServer.take(fridge, :bacon)
  end
end
