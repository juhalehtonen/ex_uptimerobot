defmodule ExUptimerobot.PSPTest do
  use ExUnit.Case, async: false
  alias ExUptimerobot.PSP
  doctest ExUptimerobot

  import Mock

  @moduletag :psp

  setup_all do
    {:ok,
      ok_answer: "{\"stat\":\"ok\",\"psps\":[]}",
      error_answer: "{\"stat\":\"fail\",\"error\":{\"type\":\"missing_parameter\",\"parameter_name\":\"friendly_name\"}}"}
  end

  test "Calling get_psps() with no user-provided params succeeds", state do
    with_mock ExUptimerobot.Request, [post: fn(_action, _params) -> {:ok, state[:ok_answer]} end] do
      assert {:ok, _body} = PSP.get_psps()
    end
  end

  test "Body returned by get_psps() contains correct looking data", state do
    with_mock ExUptimerobot.Request, [post: fn(_action, _params) -> {:ok, state[:ok_answer]} end] do
      {:ok, body} = PSP.get_psps()
      assert Map.has_key?(body, "psps")
    end
  end

  test "Adding new psp with insufficient params fails", state do
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
      assert {:error, _reason} = PSP.new_psp()
    end
  end

  test "Adding new psp without a keyword list fails" do
    assert {:error, "Params not a keyword list"} =  PSP.new_psp("failure")
  end
end
