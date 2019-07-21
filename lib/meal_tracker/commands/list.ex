defmodule MealTracker.Commands.List do
  @moduledoc """
  Handles the `track list` command.
  """

  alias MealTracker.Config

  @doc """
  Executes the command.
  """
  def run(_options) do
    files =
      Config.root()
      |> File.ls!()
      |> Enum.map(fn file_name -> String.slice(file_name, 0..-4) end)

    IO.puts(files)
  end
end
