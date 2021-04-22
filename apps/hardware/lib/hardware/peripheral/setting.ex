defmodule Hardware.Peripheral.Setting do
  @enforce_keys [
    :name,
    :type,
    :tick_rate
  ]
  defstruct [
    :name,
    :type,
    :tick_rate
  ]
end
