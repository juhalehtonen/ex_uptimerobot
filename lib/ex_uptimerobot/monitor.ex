defmodule ExUptimerobot.Monitor do
  @moduledoc """
  Interact with Monitor-related API paths:
  - [x] getMonitors
  - [x] newMonitor
  - [] editMonitor
  - [] deleteMonitor
  - [] resetMonitor
  """


  ## API PATHS

  @doc """
  Get data for all monitors, or a set of monitors as specified by params. Full
  documentation for parameters can be found from https://uptimerobot.com/api.

  ## Example
    iex> Uptimerobot.Monitor.get_monitors()
  """
  @spec get_monitors([tuple]) :: tuple
  def get_monitors(params \\ []) do
    with {:ok, body} <- ExUptimerobot.Request.post("getMonitors", params),
         {:ok, body} <- Poison.Parser.parse(body)
    do
      body
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error getting monitors"}
    end
  end

  @doc """
  Add a new monitor.

  Parameters
    friendly_name
    url
    type - 1 equals to http(s)
    interval - in seconds (needs to be a multiple of 60)

  ## Example
    iex> Uptimerobot.Monitor.new_monitor([friendly_name: "Elixir Lang", url: "http://elixir-lang.org/"])
  """
  @spec get_monitors([tuple]) :: tuple
  def new_monitor(params \\ []) do
    with {:ok, body}  <- ExUptimerobot.Request.post("newMonitor", params),
         {:ok, body}  <- Poison.Parser.parse(body),
         {:ok, _resp} <- new_monitor_status?(body)
    do
      {:ok, "Added monitor"}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "General error"}
    end
  end

  defp new_monitor_status?(body) do
    case body["stat"] do
      "ok"   -> {:ok, "Added monitor"}
      "fail" -> {:error, body["error"]}
      _      -> {:error, "Unknown error"}
    end
  end


  ## HELPERS & CONVENIENCE FUNCTIONS

  @doc """
  Get specific piece of data from within the monitors by key.

  Looks inside the nested "monitors", so does not return values outside those.

  ## Example
    iex> list_values("url")
  """
  @spec list_values(String.t) :: list
  def list_values(key) when is_binary(key) do
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
    Enum.member?(list_values("url"), url)
  end
end