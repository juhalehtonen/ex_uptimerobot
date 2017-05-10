defmodule ExUptimerobot.AlertContactTest do
  use ExUnit.Case, async: true
  alias ExUptimerobot.AlertContact
  doctest ExUptimerobot

  @moduletag :alert_contact

  test "Calling get_alert_contacts() with no user-provided params succeeds" do
    assert {:ok, _body} = AlertContact.get_alert_contacts()
  end
end