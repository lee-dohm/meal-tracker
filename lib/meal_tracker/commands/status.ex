defmodule MealTracker.Commands.Status do
  @moduledoc """
  Handles the `track status` command.
  """

  import MealTracker.DateUtils
  import MealTracker.PathUtils

  def run(_options) do
    text =
      today()
      |> log_path()
      |> File.read!()

    IO.puts(text)
  end
end
