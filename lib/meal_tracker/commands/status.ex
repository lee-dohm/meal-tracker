defmodule MealTracker.Commands.Status do
  @moduledoc """
  Displays the current day's meal log.

  Creates an empty meal log if one does not exist.

  ```
  track status
  ```
  """

  use MealTracker.Command

  alias MealTracker.Log

  @shortdoc "Display the daily meal log"

  @doc false
  def run(_options) do
    path = log_path(today())

    text =
      if File.exists?(path) do
        File.read!(path)
      else
        today()
        |> Log.new()
        |> Log.write(path)

        File.read!(path)
      end

    IO.puts(text)
  end
end
