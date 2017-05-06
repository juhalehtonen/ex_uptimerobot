defmodule ExUptimerobot.Request do
  @moduledoc """
  Sending HTTP requests to the Uptime Robot API.

  Generally you will not interact with this module directly. Instead, you will
  want to use the different modules for making API calls, which then refer to 
  this module for their POST actions.
  """
  @api_key Application.get_env(:ex_uptimerobot, :api_key)
  @api_url "https://api.uptimerobot.com/v2/"

  @doc """
  Send a POST request with a given API action and params.

  If no params are provided, only a default parameter `format=json` will be used.
  """
  def post(action, params \\ [format: "json"]) when is_binary(action) do
    url = @api_url <> action
    body = build_body(params)
    headers = [{"Content-type", "application/x-www-form-urlencoded"}]

    case HTTPoison.post(url, body, headers, [ ssl: [{:versions, [:'tlsv1.2']}] ]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "404: not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
      _ ->
        {:error, "Failed to POST"}
    end
  end

  @doc """
  Build a request body based on the passed keyword list of params.
  """
  def build_body(params) when is_list(params) do
    "api_key=" <> @api_key <> "&" <> URI.encode_query(params)
  end

  @doc """
  Check the response to determine whether the API response status returns 
  a success or a failure.
  """
  @spec response_status?(any) :: tuple
  def response_status?(body) do
    case body["stat"] do
      "ok"   -> {:ok, "Success"}
      "fail" -> {:error, body["error"]}
      _      -> {:error, "Unknown error"}
    end
  end
end