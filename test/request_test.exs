defmodule ExUptimerobot.RequestTest do
  use ExUnit.Case, async: true
  doctest ExUptimerobot

  @moduletag :request

  test "POST request with a valid action and no user-provided params succeeds" do
    assert {:ok, _body} = ExUptimerobot.Request.post("getMonitors")
  end

  test "POST request with invalid action type fails" do
    assert {:error, "Invalid action"} = ExUptimerobot.Request.post(123)
  end

  test "Building a request body from params of keyword list succeeds" do
    body = ExUptimerobot.Request.build_body([key1: "value1", key2: "value2"])
    assert is_binary(body)
  end

  test "Building a body from invalid param type fails" do
    assert {:error, "Params not a keyword list"} = ExUptimerobot.Request.build_body("failure")
  end
end