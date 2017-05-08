defmodule ExUptimerobot.MonitorTest do
  use ExUnit.Case, async: true
  doctest ExUptimerobot

  @moduletag :monitor

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

  test "Adding new monitor with insufficient params fails" do
    assert {:error, _reason} = ExUptimerobot.Monitor.new_monitor()
  end

  test "Adding new monitor with sufficient params succeeds" do
    assert {:ok, _resp} = ExUptimerobot.Monitor.new_monitor([
                            friendly_name: "Elixir Lang",
                            url: "http://elixir-lang.org/",
                            type: 1
                          ])
  end
end