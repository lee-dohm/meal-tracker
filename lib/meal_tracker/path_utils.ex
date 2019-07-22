defmodule MealTracker.PathUtils do
  alias MealTracker.Config

  def log_path(text) when is_binary(text) do
    text
    |> Date.from_iso8601()
    |> log_path()
  end

  def log_path(%Date{} = date) do
    Path.join(Config.root(), Date.to_iso8601(date) <> ".md")
  end
end
