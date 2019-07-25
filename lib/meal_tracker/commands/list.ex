defmodule MealTracker.Commands.List do
  @moduledoc """
  Displays the list of meal logs.

  ```
  track list
  ```
  """

  use MealTracker.Command

  alias MealTracker.Config

  @shortdoc "List the daily meal logs"

  @doc false
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
