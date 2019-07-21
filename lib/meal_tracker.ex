defmodule MealTracker do
  @moduledoc """
  A command-line meal tracking toolkit.
  """

  require MealTracker.Hooks

  @before_compile {MealTracker.Hooks, :inject_version}

  @doc """
  Returns the full version text for the application.
  """
  def version_text, do: "Meal Tracker #{version()}"
end
