defmodule Hardware.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Hardware.Supervisor, []}
    ]

    opts = [strategy: :one_for_one, name: Hardware.Application]
    Supervisor.start_link(children, opts)
  end
end
