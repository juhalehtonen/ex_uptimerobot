defmodule ExUptimerobot.AlertContact do
  @moduledoc """
  Interact with Alert Contact -related API methods.
  """
  alias ExUptimerobot.Request
  alias Poison.Parser

  @doc """
  Get all alert contacts, or a set of contacts as specified by params. Full
  documentation for all parameters can be found from https://uptimerobot.com/api.

  ## Example

      iex> ExUptimerobot.AlertContact.get_alert_contacts()
      {:ok, results}

  """
  @spec get_alert_contacts([tuple]) :: tuple
  def get_alert_contacts(params \\ []) do
    with {:ok, body} <- Request.post("getAlertContacts", params),
         {:ok, body} <- Parser.parse(body)
    do
      {:ok, body}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error getting alert contacts"}
    end
  end

  @doc """
  Add new alert contact with given parameters.

  Two parameters are required: `type` and `value`.
  One is optional: `friendly_name`

  ## Example

      iex> ExUptimerobot.AlertContact.new_alert_contact([friendly_name: "Main email", value: "your-email@example.com", type: 2])
      {:ok, response}

  """
  @spec new_alert_contact([tuple]) :: tuple
  def new_alert_contact(params \\ [])
  def new_alert_contact(params) when is_list(params) do
    with {:ok, body} <- Request.post("newAlertContact", params),
         {:ok, body} <- Parser.parse(body),
         {:ok, resp} <- Request.response_status?(body)
    do
      {:ok, resp}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error adding alert contact"}
    end
  end
  def new_alert_contact(_params), do: {:error, "Params not a keyword list"}

  @doc """
  Delete an existing alert contact by the ID of alert contact

  ## Example

      iex> ExUptimerobot.AlertContact.delete_alert_contact(1337)
      {:ok, response}

  """
  @spec delete_alert_contact(integer) :: tuple
  @spec delete_alert_contact(String.t) :: tuple
  def delete_alert_contact(id) do
    with {:ok, body} <- Request.post("deleteAlertContact", [format: "json", id: id]),
         {:ok, body} <- Parser.parse(body),
         {:ok, resp} <- Request.response_status?(body)
    do
      {:ok, resp}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error deleting alert contact"}
    end
  end
end
