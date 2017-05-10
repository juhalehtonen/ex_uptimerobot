defmodule ExUptimerobot.RequestTest do
  use ExUnit.Case, async: true
  alias ExUptimerobot.Request
  doctest ExUptimerobot

  @moduletag :request

  test "POST request with a valid action and no user-provided params succeeds" do
    assert {:ok, _body} = Request.post("getMonitors")
  end

  test "POST request with invalid action type fails" do
    assert {:error, "Invalid action"} = Request.post(123)
  end

  test "Building a request body from params of keyword list succeeds" do
    body = Request.build_body([key1: "value1", key2: "value2"])
    assert is_binary(body)
  end

  test "Building a body from invalid param type fails" do
    assert {:error, "Params not a keyword list"} = Request.build_body("failure")
  end
end