defmodule MealTracker.Commands.Help do
  @moduledoc """
  Handles the `track help` command.
  """

  use MealTracker.Command

  alias MealTracker.Command

  @shortdoc "Prints help information for commands"

  def run(_options) do
    IO.puts("""
    #{MealTracker.version_text()}

    These are the Meal Tracker commands:

    #{command_table()}
    """)
  end

  def command_list do
    Command.load_all()

    for module <- Command.all_modules(),
        row = {Command.module_name_to_command(module), Command.shortdoc(module)},
        do: row
  end

  def command_table do
    list =
      command_list()
      |> Enum.reject(fn {_, doc} -> is_nil(doc) end)

    longest =
      list
      |> Enum.map(&elem(&1, 0))
      |> Enum.map(&String.length/1)
      |> Enum.max()

    list
    |> Enum.map(fn {name, doc} -> String.pad_trailing(name, longest + 2) <> doc end)
    |> Enum.join("\n")
  end
end
