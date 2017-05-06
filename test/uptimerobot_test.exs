defmodule ExUptimerobotTest do
  use ExUnit.Case, async: true
  doctest ExUptimerobot

  ## REQUEST

  test "POST request with a valid action and no user-provided params succeeds" do
    assert {:ok, _body} = ExUptimerobot.Request.post("getMonitors")
  end

  test "POST request with invalid action type fails" do
    assert {:error, _reason} = ExUptimerobot.Request.post(123)
  end


  ## MONITOR 

  test "Calling get_monitors() with no user-provided params succeeds" do
    assert {:ok, _body} = ExUptimerobot.Monitor.get_monitors()
  end

  test "Body returned by get_monitors() contains correct looking data" do
    {:ok, body} = ExUptimerobot.Monitor.get_monitors()
    assert Map.has_key?(body, "monitors")
  end

  test "Listing values with a valid key returns an {:ok, list} tuple" do
    assert {:ok, _list} = ExUptimerobot.Monitor.list_values("url")  
  end

  test "Listing values with an invalid key returns an {:error, reason} tuple" do
    assert {:error, _reason} = ExUptimerobot.Monitor.list_values("nothere")  
  end


  ## ACCOUNT
  
  test "Calling get_account_details() succeeds" do
    assert {:ok, _body} = ExUptimerobot.Account.get_account_details()
  end


  ## ALERT CONTACTS

  test "Calling get_alert_contacts() with no user-provided params succeeds" do
    assert {:ok, _body} = ExUptimerobot.AlertContact.get_alert_contacts()
  end
end
