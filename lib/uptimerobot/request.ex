defmodule Uptimerobot.Request do
  @moduledoc """
  Sending HTTP requests to the Uptime Robot API.
  """
  @api_key Application.get_env(:uptimerobot, :api_key)
  @api_url "https://api.uptimerobot.com/v2/"

  def post(action) when is_binary(action) do
    url = @api_url <> action
    body = build_body(%{"format": "json"})
    headers = [{"Content-type", "application/json"}]

    case HTTPoison.post(url, body, headers, [ ssl: [{:versions, [:'tlsv1.2']}] ]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "404: not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  @doc """
  Build a request body based on the passed param map.
  """
  def build_body(params) when is_map(params) do
    Poison.encode!(%{
      "api_key": @api_key,
      "param": [ params ]
    })
  end
end