defmodule Hardware do
  alias Hardware.DynamicHardwareSupervisor

  @moduledoc """
  Documentation for `Hardware`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Hardware.hello()
      :world

  """
  def hello do
    :world
  end

  defdelegate start_hardware(setting), to: DynamicHardwareSupervisor
  defdelegate stop_hardware(setting), to: DynamicHardwareSupervisor
end
