defmodule ExUptimerobot.MonitorTest do
  use ExUnit.Case, async: true
  alias ExUptimerobot.Monitor
  doctest ExUptimerobot

  @moduletag :monitor

  test "Calling get_monitors() with no user-provided params succeeds" do
    assert {:ok, _body} = Monitor.get_monitors()
  end

  test "Body returned by get_monitors() contains correct looking data" do
    {:ok, body} = Monitor.get_monitors()
    assert Map.has_key?(body, "monitors")
  end


  test "Listing values with a valid key returns an {:ok, list} tuple" do
    assert {:ok, _list} = Monitor.list_values("url")
  end

  test "Listing values with an invalid key returns an {:error, reason} tuple" do
    assert {:error, _reason} = Monitor.list_values("nothere")
  end

  test "Listing values with invalid key type fails" do
    assert {:error, "Provided key not a string"} = Monitor.list_values(123)
  end


  test "Adding new monitor with insufficient params fails" do
    assert {:error, _reason} = Monitor.new_monitor()
  end

  test "Adding new monitor with params of wrong type fails" do
    assert {:error, "Params not a keyword list"} = Monitor.new_monitor("failure")
  end


  test "Checking if monitor is in place with wrong param type fails" do
    assert {:error, _reason} = Monitor.is_monitored?(123)
  end
end