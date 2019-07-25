defmodule MealTracker.Commands.Status do
  @moduledoc """
  Displays the current day's meal log.

  ```
  track status
  ```
  """

  use MealTracker.Command

  @shortdoc "Display the daily meal log"

  @doc false
  def run(_options) do
    text =
      today()
      |> log_path()
      |> File.read!()

    IO.puts(text)
  end
end
