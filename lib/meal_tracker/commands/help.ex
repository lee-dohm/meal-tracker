defmodule MealTracker.Commands.Help do
  @moduledoc """
  Handles the `track help` command.
  """

  def run(_options) do
    IO.puts("""
    #{MealTracker.version_text()}

    These are the common Meal Tracker commands:

    add       Add a log entry
    help      Print this help information
    list      List the daily logs
    status    Print today's log
    version   Print Meal Tracker version information
    """)
  end
end
