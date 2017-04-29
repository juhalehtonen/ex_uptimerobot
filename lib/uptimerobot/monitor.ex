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
      _ ->
        nil
    end
  end

  @doc """
  Add a new monitor.

  Parameters
    friendly_name - required
    url - required
    type - required (defaults to 1)
    interval - optional (in seconds, defaults to 1)

  ## Example
    iex> Uptimerobot.Monitor.new_monitor("Name", "http://elixir-lang.org/", "1", "1")
  """
  @spec new_monitor(String.t, String.t, String.t, String.t) :: tuple
  def new_monitor(friendly_name, url, type \\ "1", interval \\ "1") do
    params = %{
      "format": "json",
      "friendly_name": friendly_name,
      "url": url,
      "type": type,
      "interval": interval,
    }

    # TODO: Use the with keyword instead of nested cases
    case Uptimerobot.Request.post("newMonitor", params) do
      {:ok, body} ->
        case Poison.Parser.parse(body) do
          {:ok, body} ->
            case body["stat"] do
              "fail" -> {:error, body["error"]}
              "success" -> {:ok, "Added monitor"}
            end
          {:error, reason} ->
            {:error, reason}
        end
      {:error, reason} ->
        {:error, reason}
      _ ->
        {:error, "Unknown error"}
    end
  end


  ## HELPERS & CONVENIENCE FUNCTIONS

  @doc """
  Get specific piece of data from within the monitors by key.

  Looks inside the nested "monitors", so does not return values outside those.

  ## Example
    iex> get_from_monitors("url")
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