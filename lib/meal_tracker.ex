defmodule MealTracker do
  @moduledoc """
  A command-line meal tracking toolkit.
  """

  require MealTracker.Hooks

  @before_compile {MealTracker.Hooks, :inject_version}

  def version_text, do: "Meal Tracker #{version()}"
end
