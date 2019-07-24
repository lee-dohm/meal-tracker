defmodule MealTracker.Commands.Status do
  @moduledoc """
  Handles the `track status` command.
  """

  use MealTracker.Command

  @shortdoc "Display the daily meal log"

  def run(_options) do
    text =
      today()
      |> log_path()
      |> File.read!()

    IO.puts(text)
  end
end
