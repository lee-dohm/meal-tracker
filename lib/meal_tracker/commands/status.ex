defmodule MealTracker.Commands.Status do
  @moduledoc """
  Handles the `track status` command.
  """

  alias MealTracker.Helper

  def run(_options) do
    text = File.read!(Helper.today_path())

    IO.puts(text)
  end
end
