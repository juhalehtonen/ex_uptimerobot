defmodule ExUptimerobot.AccountTest do
  use ExUnit.Case, async: true
  doctest ExUptimerobot

  @moduletag :account

  test "Calling get_account_details() succeeds" do
    assert {:ok, _body} = ExUptimerobot.Account.get_account_details()
  end
end