defmodule ExUptimerobot.MonitorTest do
  use ExUnit.Case, async: false
  alias ExUptimerobot.Monitor
  doctest ExUptimerobot

  import Mock

  @moduletag :monitor

  setup_all do
    {:ok,
      ok_answer: "{\"stat\":\"ok\",\"pagination\":{\"offset\":0,\"limit\":50,\"total\":0},\"monitors\":[]}",
      error_answer: "{\"stat\":\"fail\",\"error\":{\"type\":\"missing_parameter\",\"parameter_name\":\"type\"}}"}
  end

  test "Calling get_monitors() with no user-provided params succeeds", state do
    with_mock ExUptimerobot.Request, [post: fn(_action, _params) -> {:ok, state[:ok_answer]} end] do
      assert {:ok, _body} = Monitor.get_monitors()
    end
  end


  test "Body returned by get_monitors() contains correct looking data", state do
    with_mock ExUptimerobot.Request, [post: fn(_action, _params) -> {:ok, state[:ok_answer]} end] do
      {:ok, body} = Monitor.get_monitors()
      assert Map.has_key?(body, "monitors")
    end
  end

  test "Listing values with a valid key returns an {:ok, list} tuple", state do
    with_mock ExUptimerobot.Request, [post: fn(_action, _params) -> {:ok, state[:ok_answer]} end] do
      assert {:ok, _list} = Monitor.list_values("url")
    end
  end

  test "Listing values with an invalid key returns an {:error, reason} tuple" do
    assert {:error, _reason} = Monitor.list_values("nothere")
  end

  test "Listing values with invalid key type fails" do
    assert {:error, "Provided key not a string"} = Monitor.list_values(123)
  end

  test "Adding new monitor with insufficient params fails", state do
    with_mock(ExUptimerobot.Request, [
      post: fn(_action, _params) -> {:ok, state[:error_answer]} end,
      response_status?: fn(body) ->
        case body["stat"] do
          "ok"   -> {:ok, "Success"}
          "fail" -> {:error, body["error"]}
          _      -> {:error, "Error checking response status"}
        end
      end
    ]) do
      assert {:error, _reason} = Monitor.new_monitor()
    end
  end

  test "Adding new monitor with params of wrong type fails" do
    assert {:error, "Params not a keyword list"} =  Monitor.new_monitor("failure")
  end

  test "Checking if monitor is in place with wrong param type fails" do
    assert {:error, _reason} = Monitor.is_monitored?(123)
  end
end
