defmodule MealTracker.CLI do
  @moduledoc """
  Handles the command-line interface of the meal tracker application.
  """

  alias MealTracker.{Config, FoodItem, Log}

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

  defp handle_command("help", _options) do
    IO.puts("""
    Work in progress
    """)
  end

  defp handle_command("status", _options) do
    text = File.read!(today_path())

    IO.puts(text)
  end

  defp handle_command(command, _options) do
    IO.puts("Unknown command: #{command}\n\n")

    print_help()
  end

  defp meal_tracker_path do
    config = Config.read()

    config.root
  end

  defp print_help do
    handle_command("help", [])
  end

  defp read_or_create_today do
    path = today_path()

    if File.exists?(path) do
      {:ok, log} = Log.read(path)

      log
    else
      Log.new()
    end
  end

  defp today_path do
    today = NaiveDateTime.utc_now() |> NaiveDateTime.to_date()

    Path.join(meal_tracker_path(), "#{Date.to_iso8601(today)}.md")
  end

  defp write_today(log) do
    Log.write(log, today_path())
  end
end
