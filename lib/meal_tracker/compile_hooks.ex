defmodule MealTracker.CompileHooks do
  @moduledoc """
  Compile-time hooks for the application.
  """

  @doc """
  Creates a `version/0` function that returns the version number as described at compile-time by
  git.
  """
  defmacro inject_version(_env) do
    {version, 0} = System.cmd("git", ["describe", "--tags"], cd: Path.expand("..", __DIR__))

    quote do
      @doc """
      Returns the version number of the application.
      """
      def version do
        unquote(String.trim(version))
      end
    end
  end
end
