defmodule ListSupervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init(list) do
    children = [ worker(ListServer, list) ]
    supervise children, strategy: :one_for_one
  end
end
