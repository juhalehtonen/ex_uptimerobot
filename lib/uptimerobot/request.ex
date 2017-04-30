defmodule Uptimerobot.Request do
  @moduledoc """
  Sending HTTP requests to the Uptime Robot API.
  """
  @api_key Application.get_env(:uptimerobot, :api_key)
  @api_url "https://api.uptimerobot.com/v2/"

  @doc """
  Send a POST request with a given API action and params.

  If no params are provided, a default of `%{"format": "json"}` is passed.
  """
  def post(action, params \\ %{format: "json"}) when is_binary(action) do
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
        {:error, "Unexpected error"}
    end
  end

  @doc """
  Build a request body based on the passed param map.
  """
  def build_body(params) when is_map(params) do
    "api_key=" <> @api_key <> "&" <> URI.encode_query(params)
  end
end