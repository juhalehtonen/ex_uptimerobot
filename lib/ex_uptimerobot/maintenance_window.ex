defmodule ExUptimerobot.MaintenanceWindow do
  @moduledoc """
  Interact with Maintenance window -related API methods.
  """
  alias ExUptimerobot.Request
  alias Poison.Parser

  @doc """
  Get the list of maintenance windows.

  ## Example

      iex> ExUptimerobot.MaintenanceWindow.get()
      {:ok, results}

  """
  @spec get([tuple]) :: tuple
  def get(params \\ []) do
    with {:ok, body} <- Request.post("getMWindows", params),
         {:ok, body} <- Parser.parse(body)
    do
      {:ok, body}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error getting maintenance windows"}
    end
  end
end
