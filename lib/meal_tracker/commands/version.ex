defmodule MealTracker.Commands.Version do
  @moduledoc """
  Handles the `track version` command.
  """

  use MealTracker.Command

  @shortdoc "Display the Meal Tracker version information"

  def run(_options) do
    IO.puts(MealTracker.version_text())
  end
end
