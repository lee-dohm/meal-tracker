defmodule MealTracker.Hooks do
  @moduledoc false

  defmacro inject_version(_env) do
    {version, 0} = System.cmd("git", ["describe", "--tags"], cd: Path.expand("..", __DIR__))

    quote do
      def version do
        unquote(String.trim(version))
      end
    end
  end
end
