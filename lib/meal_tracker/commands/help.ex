defmodule MealTracker.Commands.Help do
  @moduledoc """
  Displays delp for the application or a command.

  ```
  track help [COMMAND]
  ```
  """

  use MealTracker.Command

  alias MealTracker.Command

  @shortdoc "Prints help information for commands"

  @doc false
  def run(_options) do
    IO.puts("""
    #{MealTracker.version_text()}

    These are the Meal Tracker commands:

    #{command_table()}
    """)
  end

  defp command_list do
    Command.load_all()

    for module <- Command.all_modules(),
        row = {Command.module_name_to_command(module), Command.shortdoc(module)},
        do: row
  end

  defp command_table do
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
