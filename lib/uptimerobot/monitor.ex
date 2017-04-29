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
  def get_monitors do
    case Uptimerobot.Request.post("getMonitors") do
      {:ok, body} ->
        body
        |> Poison.Parser.parse
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Add a new monitor.
  """
  def new_monitor do
    nil
  end


  ## HELPERS & CONVENIENCE FUNCTIONS

  @doc """
  Get specific piece of data from within the monitors by key.

  Looks inside the nested "monitors", so does not return values outside those.

  ## Example
    iex > get_from_monitors("url")
  """
  @spec get_from_monitors(String.t) :: list
  def get_from_monitors(key) when is_binary(key) do
    case get_monitors() do
      {:ok, body} ->
        Enum.reduce(get_in(body, ["monitors"]), [], fn(x, acc) ->
          [x[key] | acc]
        end)
      {:error, reason} ->
        {:error, reason}
      _ ->
        {:error, "Unexpected error"}
    end
  end

  @doc """
  Check if a given URL is being monitored.
  """
  @spec is_monitored?(String.t) :: boolean
  def is_monitored?(url) when is_binary(url) do
    Enum.member?(get_from_monitors("url"), url)
  end
end