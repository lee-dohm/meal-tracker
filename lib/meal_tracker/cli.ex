defmodule MealTracker.CLI do
  @moduledoc """
  Handles the command-line interface of the meal tracker application.
  """

  alias MealTracker.Commands.{Add, List, Status, Version}

  def main(argv \\ []) do
    case argv do
      [] -> print_help()
      [command | options] -> handle_command(command, options)
    end
  end

  defp handle_command("add", options), do: Add.run(options)
  defp handle_command("help", _options), do: print_help()
  defp handle_command("list", options), do: List.run(options)
  defp handle_command("status", options), do: Status.run(options)
  defp handle_command("version", options), do: Version.run(options)

  defp handle_command(command, _options) do
    IO.puts("Unknown command: #{command}\n\n")

    print_help()
  end

  defp print_help do
    Version.run([])

    IO.puts("""

    These are the common Meal Tracker commands:

    add       Add a log entry
    help      Print this help information
    list      List the daily logs
    status    Print today's log
    version   Print Meal Tracker version information
    """)
  end
end
