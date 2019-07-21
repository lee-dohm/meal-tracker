defmodule MealTracker.Helper do
  alias MealTracker.Config

  def today_path do
    today = NaiveDateTime.utc_now() |> NaiveDateTime.to_date()

    Path.join(Config.root(), "#{Date.to_iso8601(today)}.md")
  end
end
