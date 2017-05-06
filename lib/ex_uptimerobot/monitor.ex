defmodule ExUptimerobot.Monitor do
  @moduledoc """
  Interact with Monitor-related API methods.
  """
  alias ExUptimerobot.Request


  ## API PATHS

  @doc """
  Get data for all monitors, or a set of monitors as specified by params. Full
  documentation for all possible parameters can be found from https://uptimerobot.com/api.

  ## Example

    iex> ExUptimerobot.Monitor.get_monitors()
    {:ok, %{"monitors" => [%{"create_datetime" => 0, "friendly_name" => "Elixir Lang"}]}
    
  """
  @spec get_monitors([tuple]) :: tuple
  def get_monitors(params \\ []) do
    with {:ok, body} <- Request.post("getMonitors", params),
         {:ok, body} <- Poison.Parser.parse(body)
    do
      {:ok, body}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error getting monitors"}
    end
  end

  @doc """
  Add a new monitor with given parameters.

  Three parameters are required: `friendly_name`, `url` and `type`.

  ## Example

    iex> ExUptimerobot.Monitor.new_monitor([friendly_name: "Elixir Lang", url: "http://elixir-lang.org/", type: 1])
    {:ok, "Added monitor"}

  """
  @spec new_monitor([tuple]) :: tuple
  def new_monitor(params \\ []) do
    with {:ok, body}  <- Request.post("newMonitor", params),
         {:ok, body}  <- Poison.Parser.parse(body),
         {:ok, _resp} <- Request.response_status?(body)
    do
      {:ok, "Added monitor"}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "General error"}
    end
  end


  @doc """
  Delete an existing monitor by the monitor ID.
  """
  @spec delete_monitor(integer) :: tuple
  @spec delete_monitor(String.t) :: tuple
  def delete_monitor(id) do
    with {:ok, body} <- Request.post("deleteMonitor", [format: "json", id: id]),
         {:ok, body} <- Poison.Parser.parse(body),
         {:ok, _resp} <- Request.response_status?(body)
    do
      {:ok, "Deleted monitor #{id}"}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error deleting monitor"}
    end
  end

  @doc """
  Reset (delete all stats and response time data) a monitor by the monitor ID.
  """
  @spec reset_monitor(integer) :: tuple
  @spec reset_monitor(String.t) :: tuple
  def reset_monitor(id) do
    with {:ok, body} <- Request.post("resetMonitor", [format: "json", id: id]),
         {:ok, body} <- Poison.Parser.parse(body),
         {:ok, _resp} <- Request.response_status?(body)
    do
      {:ok, "Reset monitor #{id}"}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error resetting monitor"}
    end
  end


  ## HELPERS & CONVENIENCE FUNCTIONS

  @doc """
  Returns `{:ok, values}` where `values` is a list of each values for given key
  per project.

  ## Example

    iex> ExUptimerobot.Monitor.list_values("url")
    {:ok, ["http://elixir-lang.org/", "https://www.erlang.org/"]}

  """
  @spec list_values(String.t) :: tuple
  def list_values(key) when is_binary(key) do
    case get_monitors() do
      {:ok, body} ->
        {:ok, 
          Enum.reduce(get_in(body, ["monitors"]), [], fn(x, acc) ->
           [x[key] | acc]
          end)
        }
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
    case list_values("url") do
      {:ok, body} -> Enum.member?(body, url)
      {:error, reason} -> {:error, reason}
    end
  end
end