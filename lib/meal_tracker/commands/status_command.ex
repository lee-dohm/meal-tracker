defmodule MealTracker.Commands.StatusCommand do
  alias MealTracker.Helper

  def run(_options) do
    text = File.read!(Helper.today_path())

    IO.puts(text)
  end
end
