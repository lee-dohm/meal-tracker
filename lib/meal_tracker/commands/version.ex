defmodule MealTracker.Commands.Version do
  @moduledoc """
  Handles the `track version` command.
  """

  def run(_options) do
    IO.puts(MealTracker.version_text())
  end
end
