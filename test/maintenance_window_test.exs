defmodule ExUptimerobot.MaintenanceWindowTest do
  use ExUnit.Case, async: true
  alias ExUptimerobot.MaintenanceWindow
  doctest ExUptimerobot

  @moduletag :maintenance_window

  test "Getting all maintenance windows with no specific params succeeds" do
    assert {:ok, _body} = MaintenanceWindow.get_maintenance_windows()
  end

  test "Adding new maintenance window with insufficient params fails" do
    assert {:error, _reason} = MaintenanceWindow.new_maintenance_window()
  end

  test "Adding new maintenance window with params of wrong type fails" do
    assert {:error, _reason} = MaintenanceWindow.new_maintenance_window("failure")
  end
end