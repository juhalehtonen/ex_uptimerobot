defmodule ExUptimerobot.AlertContactTest do
  use ExUnit.Case, async: true
  alias ExUptimerobot.AlertContact
  doctest ExUptimerobot

  @moduletag :alert_contact

  test "Calling get_alert_contacts() with no user-provided params succeeds" do
    assert {:ok, _body} = AlertContact.get_alert_contacts()
  end

  test "Adding new alert contact with insufficient params fails" do
    assert {:error, _reason} = AlertContact.new_alert_contact()
  end

  test "Adding new alert contact with params of wrong type fails" do
    assert {:error, "Params not a keyword list"} = AlertContact.new_alert_contact("failure")
  end
end
