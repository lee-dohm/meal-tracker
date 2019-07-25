defmodule MealTracker.Commands.Version do
  @moduledoc """
  Displays the Meal Tracker version information.

  ```
  track version
  ```
  """

  use MealTracker.Command

  @shortdoc "Display the Meal Tracker version information"

  @doc false
  def run(_options) do
    IO.puts(MealTracker.version_text())
  end
end
