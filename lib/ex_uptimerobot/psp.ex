defmodule ExUptimerobot.PSP do
  @moduledoc """
  Interact with Public Status Page - related API methods.
  """

  alias ExUptimerobot.Request
  alias Poison.Parser

  @doc """
  Get the list of public status pages

  ## Example

      iex> ExUptimerobot.AlertContact.get_psps()
      {:ok, results}

  """
  @spec get_psps([tuple]) :: tuple
  def get_psps(params \\ []) do
    with {:ok, body} <- Request.post("getPSPs", params),
         {:ok, body} <- Parser.parse(body)
    do
      {:ok, body}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error getting PSPs"}
    end
  end

  @doc """
  Create a new public status page with given parameters.

  Required: `friendly_name`, `monitors`.

  Optional: `custom_domain`, `sort`, `hide_url_links`, `status`.

  ## Example

      iex> ExUptimerobot.PSP.new_psp([friendly_name: "New PSP", monitors: 0])
      {:ok, response}

  """
  @spec new_psp([tuple]) :: tuple
  def new_psp(params \\ [])
  def new_psp(params) when is_list(params) do
    with {:ok, body}  <- Request.post("newPSP", params),
         {:ok, body}  <- Parser.parse(body),
         {:ok, resp}  <- Request.response_status?(body)
    do
      {:ok, resp}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error adding PSP"}
    end
  end
  def new_psp(_params), do: {:error, "Params not a keyword list"}

  @doc """
  Edit the public status page with given parameters.

  Required: `id`.
  Optional: `friendly_name`, `monitors`, `custom_domain`, `sort`, `hide_url_links`, `status`.

  ## Example

      iex> ExUptimerobot.PSP.edit_psp([id: 1337, friendly_name: "Edited PSP", monitors: "123-456"])
      {:ok, response}

  """
  @spec edit_psp([tuple]) :: tuple
  def edit_psp(params \\ [])
  def edit_psp(params) when is_list(params) do
    with {:ok, body}  <- Request.post("editPSP", params),
         {:ok, body}  <- Parser.parse(body),
         {:ok, resp}  <- Request.response_status?(body)
    do
      {:ok, resp}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error editing PSP"}
    end
  end
  def edit_psp(_params), do: {:error, "Params not a keyword list"}

  @doc """
  Delete an existing public status page by given ID

  ## Example

      iex> ExUptimerobot.PSP.delete_psp(1337)
      {:ok, response}

  """
  @spec delete_psp(integer) :: tuple
  @spec delete_psp(String.t) :: tuple
  def delete_psp(id) do
    with {:ok, body} <- Request.post("deletePSP", [format: "json", id: id]),
         {:ok, body} <- Parser.parse(body),
         {:ok, resp} <- Request.response_status?(body)
    do
      {:ok, resp}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error deleting PSP"}
    end
  end
end
