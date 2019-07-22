defmodule MealTracker.Helper do
  alias MealTracker.Config

  def today do
    :calendar.local_time()
    |> NaiveDateTime.from_erl!()
    |> NaiveDateTime.to_date()
  end

  def today_path do
    Path.join(Config.root(), "#{Date.to_iso8601(today())}.md")
  end
end
