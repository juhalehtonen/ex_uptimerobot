defmodule ExUptimerobot.Account do
  @moduledoc """
  Interact with Account-related API methods.
  """

  @doc """
  Account details (max number of monitors that can be added and number of 
  up/down/paused monitors) can be grabbed using this method.
  """
  def get_account_details do
    with {:ok, body} <- ExUptimerobot.Request.post("getAccountDetails"),
         {:ok, body} <- Poison.Parser.parse(body)
    do
      {:ok, body}
    else
      {:error, reason} -> {:error, reason}
      _                -> {:error, "Error getting account details"}
    end
  end
end