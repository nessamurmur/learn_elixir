defmodule XYComponent do
  use GenEvent.Behaviour

  # Public API
  def move(pid, coordinate) do
    :gen_event.call(pid, __MODULE__, {:move, coordinate})
  end

  def get_position(pid) do
    :gen_event.call(pid, __MODULE__, :get_position)
  end

  # GenEvent API
  def init(coordinates\\{50, 50}) do
    {:ok, coordinates}
  end

  def handle_event({:move, {:x, new_x}}, {_, y}) do
    {:ok, {new_x, y}}
  end

  def handle_event({:move, {:y, new_y}}, {x, _}) do
    {:ok, {x, new_y}}
  end

  def handle_call(:get_position, coordinates) do
    {:ok, coordinates, coordinates}
  end
end
