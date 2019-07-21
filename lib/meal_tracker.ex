defmodule MealTracker do
  @moduledoc """
  A command-line meal tracking toolkit.
  """

  @version MealTracker.MixProject.project() |> Keyword.fetch!(:version)

  def version, do: @version

  def version_text, do: "Meal Tracker v#{@version}"
end
