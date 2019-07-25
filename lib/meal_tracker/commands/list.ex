defmodule MealTracker.Commands.List do
  @moduledoc """
  Displays the list of meal logs.

  ```
  track list
  ```

  Displays from oldest to newest by default.
  """

  use MealTracker.Command

  alias MealTracker.Config

  @shortdoc "List the daily meal logs"

  @doc false
  def run(_options) do
    Config.root()
    |> File.ls!()
    |> Enum.map(fn file_name -> String.slice(file_name, 0..-4) end)
    |> Enum.sort()
    |> Enum.join("\n")
    |> IO.puts()
  end
end
