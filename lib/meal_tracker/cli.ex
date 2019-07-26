defmodule MealTracker.CLI do
  @moduledoc """
  Handles the command-line interface of the meal tracker application.
  """

  alias MealTracker.Command
  alias MealTracker.Commands.Help

  def main(argv \\ []) do
    case argv do
      [] -> Help.run([])
      [command | options] -> handle_command(command, options)
    end
  end

  defp handle_command(command, options) do
    case get_commands()[command] do
      nil ->
        IO.puts("Unknown command: #{command}\n\n")

        Help.run([])

        exit({:shutdown, 1})

      mod ->
        apply(mod, :run, [options])
    end
  end

  defp get_commands do
    Command.load_all()

    Enum.reduce(Command.all_modules(), %{}, fn mod, acc ->
      Map.put(acc, Command.module_name_to_command(mod), mod)
    end)
  end
end
