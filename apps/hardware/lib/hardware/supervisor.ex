defmodule Hardware.Supervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      {Hardware.DynamicHardwareSupervisor, []}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end
