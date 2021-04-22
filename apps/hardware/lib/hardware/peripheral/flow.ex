defmodule Hardware.Peripheral.Flow do
  use GenServer, restart: :temporary
  require Logger

  defmodule State do
    @enforce_keys [
      :name,
      :type
    ]
    defstruct [
      :name,
      :type,
      :tick_rate,
      :timer
    ]
  end

  def start_link(%Hardware.Peripheral.Setting{} = setting) do
    Logger.notice("Starting link: #{__MODULE__}-#{setting.name}")

    GenServer.start_link(
      __MODULE__,
      %State{
        name: setting.name,
        type: setting.type,
        tick_rate: setting.tick_rate
      },
      name: :"#{__MODULE__}-#{setting.name}"
    )
  end

  def init(%State{} = state) do
    timer = Process.send_after(self(), :tick, state.tick_rate)
    {:ok, %State{state | timer: timer}}
  end

  def handle_info(:tick, %State{} = state) do
    Logger.debug("Got tick")

    timer = Process.send_after(self(), :tick, state.tick_rate)
    {:noreply, %State{state | timer: timer}}
  end

  def handle_info(_event, %State{} = state) do
    {:noreply, state}
  end
end
