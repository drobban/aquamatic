defmodule Hardware.DynamicHardwareSupervisor do
  use DynamicSupervisor
  require Logger

  @table %{flow: Elixir.Hardware.Peripheral.Flow}

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_hardware(%Hardware.Peripheral.Setting{} = m) do
    case get_pid(m) do
      nil ->
        Logger.info("Starting #{m.name} hardware")
        {:ok, _pid} = starting_hardware(m)

      pid ->
        Logger.warn("#{m.name} hardware already started")
        {:ok, pid}
    end
  end

  def stop_hardware(m) do
    case get_pid(m) do
      nil ->
        Logger.warn("#{m.name} hardware is already stopped")

      pid ->
        Logger.info("Stopping #{m.name} hardware")

        :ok =
          DynamicSupervisor.terminate_child(
            __MODULE__,
            pid
          )

        {:ok, m}
    end
  end

  defp get_pid(m) do
    Process.whereis(:"#{@table[m.type]}-#{m.name}")
  end

  defp starting_hardware(m) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {@table[m.type], m}
    )
  end
end
