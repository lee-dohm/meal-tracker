defmodule MealTracker.Commands.List do
  @moduledoc """
  Handles the `track list` command.
  """

  use MealTracker.Command

  alias MealTracker.Config

  @shortdoc "List the daily meal logs"

  @doc """
  Executes the command.
  """
  def run(_options) do
    files =
      Config.root()
      |> File.ls!()
      |> Enum.map(fn file_name -> String.slice(file_name, 0..-4) end)
      |> Enum.reverse()
      |> Enum.join("\n")

    IO.puts(files)
  end
end
