defmodule MealTracker do
  @moduledoc """
  A command-line meal tracking toolkit.
  """

  require MealTracker.CompileHooks

  @before_compile {MealTracker.CompileHooks, :inject_version}

  @doc """
  Returns the full version text for the application.
  """
  def version_text, do: "Meal Tracker #{version()}"
end
