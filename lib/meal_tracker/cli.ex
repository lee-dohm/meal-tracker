defmodule MealTracker.CLI do
  @moduledoc """
  Handles the command-line interface of the meal tracker application.
  """

  alias MealTracker.Commands.{Add, Edit, Help, List, Status, Version}

  def main(argv \\ []) do
    case argv do
      [] -> Help.run([])
      [command | options] -> handle_command(command, options)
    end
  end

  defp handle_command("add", options), do: Add.run(options)
  defp handle_command("edit", options), do: Edit.run(options)
  defp handle_command("help", options), do: Help.run(options)
  defp handle_command("list", options), do: List.run(options)
  defp handle_command("status", options), do: Status.run(options)
  defp handle_command("version", options), do: Version.run(options)

  defp handle_command(command, _options) do
    IO.puts("Unknown command: #{command}\n\n")

    Help.run([])
  end
end
