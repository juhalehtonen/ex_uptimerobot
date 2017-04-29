defmodule Uptimerobot.Monitor do
  @moduledoc """
  Interact with Monitor-related API paths:
  - getMonitors
  - newMonitor
  - editMonitor
  - deleteMonitor
  - resetMonitor
  """


  ## API PATHS

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

  @doc """
  Add a new monitor.
  """
  def new_monitor() do
    nil
  end


  ## HELPERS & CONVENIENCE FUNCTIONS

  @doc """
  Get specific pieces of data from a get_monitors call.

  Desired Data is passed as a list.
  """
  def get_from_monitors(data) when is_list(data) do
    get_monitors()
  end

  @doc """
  Check if a given URL is being monitored.
  """
  def is_monitored?(url) when is_binary(url) do
    nil
  end
end