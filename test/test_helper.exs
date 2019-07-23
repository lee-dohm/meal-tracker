ExUnit.start()

defmodule Support.TempUtils do
  @moduledoc """
  Utilities for dealing with temporary files.
  """

  @doc """
  Generates a uniquely-named file in the system temp directory.
  """
  def temp_path(ext \\ ".md") do
    dir = System.tmp_dir!()
    filename = "#{System.unique_integer([:positive])}#{ext}"

    Path.join(dir, filename)
  end
end

defmodule MealTracker.Commands.ReturnNil do
  def run(_) do
    nil
  end
end
