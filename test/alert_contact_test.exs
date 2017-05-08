defmodule ExUptimerobot.AlertContactTest do
  use ExUnit.Case, async: true
  doctest ExUptimerobot

  @moduletag :alert_contact

  test "Calling get_alert_contacts() with no user-provided params succeeds" do
    assert {:ok, _body} = ExUptimerobot.AlertContact.get_alert_contacts()
  end
end