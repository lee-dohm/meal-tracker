defmodule MealTracker.CLI do
  @moduledoc """
  Handles the command-line interface of the meal tracker application.
  """

  alias MealTracker.{FoodItem, Helper, Log}
  alias MealTracker.Commands.ListCommand

  @version "0.1.0"

  def main(argv \\ []) do
    case argv do
      [] -> print_help()
      [command | options] -> handle_command(command, options)
    end
  end

  defp handle_command("add", options) do
    entry =
      options
      |> Enum.join(" ")
      |> FoodItem.parse()

    read_or_create_today()
    |> Log.add_entry(entry)
    |> write_today()
  end

  defp handle_command("help", _options), do: print_help()

  defp handle_command("list", options), do: ListCommand.run(options)

  defp handle_command("status", _options) do
    text = File.read!(Helper.today_path())

    IO.puts(text)
  end

  defp handle_command("version", _options), do: print_version()

  defp handle_command(command, _options) do
    IO.puts("Unknown command: #{command}\n\n")

    print_help()
  end

  defp print_help do
    print_version()

    IO.puts("""

    These are the common Meal Tracker commands:

    add       Add a log entry
    help      Print this help information
    list      List the daily logs
    status    Print today's log
    version   Print Meal Tracker version information
    """)
  end

  defp print_version do
    IO.puts("Meal Tracker v#{@version}")
  end

  defp read_or_create_today do
    path = Helper.today_path()

    if File.exists?(path) do
      {:ok, log} = Log.read(path)

      log
    else
      Log.new()
    end
  end

  defp write_today(log) do
    Log.write(log, Helper.today_path())
  end
end
