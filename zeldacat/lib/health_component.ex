defmodule HealthComponent do
  use GenEvent.Behaviour

  # Public API
  def get_hp(entity) do
    :gen_event.call(entity, __MODULE__, :get_hp)
  end

  def alive?(entity) do
    :gen_event.call(entity, __MODULE__, :alive?)
  end

  # GenEvent API
  def init(hp) do
    {:ok, hp}
  end

  def handle_call(:get_hp, hp) do
    {:ok, hp, hp}
  end

  def handle_event({:hit, damage}, hp) do
    {:ok, hp - damage}
  end

  def handle_event({:heal, health}, hp) do
    {:ok, hp + health}
  end

  def handle_call(:alive?, hp) when hp < 1 do
    {:ok, false, hp}
  end

  def handle_call(:alive?, hp) do
    {:ok, true, hp}
  end
end
