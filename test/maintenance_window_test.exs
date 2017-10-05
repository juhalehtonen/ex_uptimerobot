defmodule ExUptimerobot.MaintenanceWindowTest do
  use ExUnit.Case, async: false
  alias ExUptimerobot.MaintenanceWindow
  doctest ExUptimerobot

  import Mock

  @moduletag :maintenance_window

  setup_all do
    {:ok,
      ok_answer: "{\"stat\":\"ok\",\"pagination\":{\"offset\":0,\"limit\":50,\"total\":0},\"monitors\":[]}",
      error_answer: "{\"stat\":\"fail\",\"error\":{\"type\":\"invalid_parameter\",\"parameter_name\":\"type\",\"message\":\"'type' must be a number\"}",
      edit_ok_answer: "{\"stat\":\"ok\",\"mwindow\":{\"id\":14362}}"}
  end

  test "Getting all maintenance windows with no specific params succeeds", state do
    with_mock ExUptimerobot.Request, [post: fn(_action, _params) -> {:ok, state[:ok_answer]} end] do
      assert {:ok, _body} = MaintenanceWindow.get_maintenance_windows()
    end
  end

  test "Adding new maintenance window with insufficient params fails", state do
    with_mock ExUptimerobot.Request, [post: fn(_action, _params) -> {:ok, state[:error_answer]} end] do
      assert {:error, _reason} = MaintenanceWindow.new_maintenance_window()
    end
  end

  test "Adding new maintenance window with params of wrong type fails" do
    assert {:error, _reason} = MaintenanceWindow.new_maintenance_window("failure")
  end

  test "Editing maintenance window with correct id succeeds", state do
    with_mock(ExUptimerobot.Request, [
      post: fn(_action, _params) -> {:ok, state[:edit_ok_answer]} end,
      response_status?: fn(body) ->
        case body["stat"] do
          "ok"   -> {:ok, "Success"}
          "fail" -> {:error, body["error"]}
          _      -> {:error, "Error checking response status"}
        end
      end
    ]) do
      assert {:ok, "Success"} = MaintenanceWindow.edit_maintenance_window([friendly_name: "Name 3", id: 14362])
    end
  end
end
