defmodule ExUptimerobot.AccountTest do
  use ExUnit.Case, async: false
  alias ExUptimerobot.Account
  doctest ExUptimerobot

  import Mock

  @moduletag :account

  setup_all do
    {:ok,
      ok_answer: "{\"stat\":\"ok\",\"account\":{\"email\":\"test@test.ru\",\"monitor_limit\":50,\"monitor_interval\":5,\"up_monitors\":0,\"down_monitors\":0,\"paused_monitors\":0}}"}
  end

  test "Calling get_account_details() succeeds", state do
    with_mock ExUptimerobot.Request, [post: fn(_action) -> {:ok, state[:ok_answer]} end] do
      assert {:ok, _body} = Account.get_account_details()
    end
  end
end
