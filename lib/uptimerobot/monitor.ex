defmodule Uptimerobot.Monitor do
  @moduledoc """
  Interact with Monitor-related API paths:
  - getMonitors
  - newMonitor
  - editMonitor
  - deleteMonitor
  - resetMonitor
  """

  @doc """
  Get data for all monitors.
  """
  def get_monitors() do
    case Uptimerobot.Request.post("getMonitors") do
      {:ok, body} ->
        body
      {:error, reason} ->
        reason
    end
  end
end