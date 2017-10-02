defmodule ExUptimerobot.RequestTest do
  use ExUnit.Case, async: false
  alias ExUptimerobot.Request
  doctest ExUptimerobot

  import Mock

  @moduletag :request


  test "POST request with a valid action and no user-provided params succeeds" do
    with_mock Request, [post: fn(_action) -> {:ok, "_body"} end] do
      assert {:ok, _body} = Request.post("getMonitors")
    end
  end

  test "POST request with invalid action type fails" do
    with_mock(Request, [
      post: fn
        (action) when is_binary(action) -> {:ok, "_body"}
        (_action) -> {:error, "Invalid action"}
      end
    ]) do
      assert {:error, "Invalid action"} = Request.post(123)
    end
  end

  test "Building a request body from params of keyword list succeeds" do
    body = Request.build_body([key1: "value1", key2: "value2"])
    assert is_binary(body)
  end

  test "Building a body from invalid param type fails" do
    assert {:error, "Params not a keyword list"} = Request.build_body("failure")
  end
end
