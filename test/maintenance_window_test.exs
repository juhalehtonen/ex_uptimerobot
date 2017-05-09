defmodule ExUptimerobot.MaintenanceWindowTest do
  use ExUnit.Case, async: true
  doctest ExUptimerobot

  @moduletag :maintenance_window

  test "Getting all maintenance windows with no specific params succeeds" do
    assert {:ok, _body} = ExUptimerobot.MaintenanceWindow.get()
  end
end