defmodule MealTracker.Commands.Version do
  def run(_options) do
    IO.puts(MealTracker.version_text())
  end
end
