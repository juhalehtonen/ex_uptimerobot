defmodule ExUptimerobot.MaintenanceWindow do
  @moduledoc """
  Interact with Maintenance window -related API methods.
  """
  alias ExUptimerobot.Request
  alias Poison.Parser

  @doc """
  Get the list of maintenance windows.

  ## Example

      iex> ExUptimerobot.MaintenanceWindow.get_maintenance_windows()
      {:ok, results}

  """
  @spec get_maintenance_windows([tuple]) :: tuple()
  def get_maintenance_windows(params \\ []) do
    with {:ok, body} <- Request.post("getMWindows", params),
         {:ok, body} <- Parser.parse(body)
    do
      {:ok, body}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error getting maintenance windows"}
    end
  end

  @doc """
  Add a new maintenance window.

  Required params:
  - `friendly_name`
  - `type`
  - `value` (only needed for weekly and monthly maintenance windows)
  - `start_time` (start datetime)
  - `duration` (how many minutes the maintenace window will be active for)

  ## Example

      MaintenanceWindow.new_maintenance_window([
        friendly_name: "Maintenance window name",
        type: 1,
        start_time: "1612083323",
        duration: "30"
      ])
      {:ok, response}

  """
  @spec new_maintenance_window([tuple]) :: tuple()
  def new_maintenance_window(params \\ [])
  def new_maintenance_window(params) when is_list(params) do
    with {:ok, body}  <- Request.post("newMWindow", params),
         {:ok, body}  <- Parser.parse(body),
         {:ok, resp}  <- Request.response_status?(body)
    do
      {:ok, resp}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error adding new maintenance window"}
    end
  end
  def new_maintenance_window(_params), do: {:error, "Params not a keyword list"}

  @doc """
  Edit maintenance window with given id.

  Required params:
  - `id`
  - `friendly_name`
  - `value` (only needed for weekly and monthly maintenance windows)
  - `start_time` (start datetime)
  - `duration` (how many minutes the maintenace window will be active for)

  ## Example

      MaintenanceWindow.edit_maintenance_window([
        id: 14362
        friendly_name: "New window name",
        start_time: "1612083323",
        duration: "30"
      ])
      {:ok, response}

  """
  @spec edit_maintenance_window([tuple]) :: tuple()
  def edit_maintenance_window(params \\ [])
  def edit_maintenance_window(params) when is_list(params) do
    with {:ok, body}  <- Request.post("editMWindow", params),
         {:ok, body}  <- Parser.parse(body),
         {:ok, resp}  <- Request.response_status?(body)
    do
      {:ok, resp}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error editing maintenance window"}
    end
  end
  def edit_maintenance_window(_params), do: {:error, "Params not a keyword list"}

  @doc """
  Delete an existing maintenance window by the maintenance window ID.

  Required parameters:
  - id (the ID of the maintenance window)

  ## Example

      ExUptimerobot.MaintenanceWindow.delete_maintenance_window(2414745)
      {:ok, resp}

  """
  @spec delete_maintenance_window(integer) :: tuple()
  @spec delete_maintenance_window(String.t) :: tuple()
  def delete_maintenance_window(id) do
    with {:ok, body} <- Request.post("deleteMWindow", [format: "json", id: id]),
         {:ok, body} <- Parser.parse(body),
         {:ok, resp} <- Request.response_status?(body)
    do
      {:ok, resp}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error deleting maintenance window"}
    end
  end
end
