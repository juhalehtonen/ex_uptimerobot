defmodule ExUptimerobot.RequestTest do
  use ExUnit.Case, async: true
  doctest ExUptimerobot

  @moduletag :request

  test "POST request with a valid action and no user-provided params succeeds" do
    assert {:ok, _body} = ExUptimerobot.Request.post("getMonitors")
  end

  test "POST request with invalid action type fails" do
    assert {:error, _reason} = ExUptimerobot.Request.post(123)
  end
end