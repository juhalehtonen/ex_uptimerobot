defmodule ExUptimerobot.AlertContactTest do
  use ExUnit.Case, async: false
  alias ExUptimerobot.AlertContact
  doctest ExUptimerobot

  import Mock

  @moduletag :alert_contact

  setup_all do
    {:ok,
      ok_answer: "{\"stat\":\"ok\",\"offset\":0,\"limit\":50,\"total\":1,\"alert_contacts\":[{\"id\":\"0498084\",\"friendly_name\":\"test@test.ru\",\"type\":2,\"status\":1,\"value\":\"test@test.ru\"}]}",
      error_answer: "{\"stat\":\"fail\",\"error\":{\"type\":\"missing_parameter\",\"parameter_name\":\"type\"}}"}
  end

  test "Calling get_alert_contacts() with no user-provided params succeeds", state do
    with_mock ExUptimerobot.Request, [post: fn(_action, _params) -> {:ok, state[:ok_answer]} end] do
      assert {:ok, _body} = AlertContact.get_alert_contacts()
    end
  end

  test "Adding new alert contact with insufficient params fails", state do
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
      assert {:error, _reason} = AlertContact.new_alert_contact()
    end
  end

  test "Adding new alert contact with params of wrong type fails" do
    assert {:error, "Params not a keyword list"} = AlertContact.new_alert_contact("failure")
  end
end
