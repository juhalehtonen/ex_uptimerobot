defmodule Uptimerobot.Monitor do
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
  Get data for all monitors.
  TODO: Add support for pagination (limit & offset) past 50 monitors.
  """
  @spec get_monitors() :: tuple
  def get_monitors do
    case Uptimerobot.Request.post("getMonitors") do
      {:ok, body} ->
        body
        |> Poison.Parser.parse()
      {:error, reason} ->
        {:error, reason}
      _ ->
        {:error, "Unknown error"}
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
    iex> Uptimerobot.Monitor.new_monitor("Elixir Lang", "http://elixir-lang.org/", "1", "60")
  """
  @spec new_monitor(String.t, String.t, String.t, String.t) :: tuple
  def new_monitor(friendly_name, url, type, interval \\ "60") do
    params = %{
      format: "json",
      friendly_name: friendly_name,
      url: url,
      type: type,
      interval: interval
    }

    with {:ok, body}  <- Uptimerobot.Request.post("newMonitor", params),
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