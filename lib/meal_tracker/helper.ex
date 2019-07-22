defmodule MealTracker.Helper do
  @moduledoc """
  Utility functions that are useful throughout the app.
  """

  alias MealTracker.Config

  @doc """
  Gets today's date.

  ## Examples

  ```
  iex> MealTracker.Helper.today()
  ~D[2019-07-21]
  ```
  """
  @spec today() :: Date.t()
  def today do
    :calendar.local_time()
    |> NaiveDateTime.from_erl!()
    |> NaiveDateTime.to_date()
  end

  @doc """
  Gets the path to today's log file.

  ## Examples

  ```
  iex> MealTracker.Helper.today_path()
  "/Users/username/meal-tracker/2019-07-21.md"
  ```
  """
  @spec today_path() :: String.t()
  def today_path do
    Path.join(Config.root(), "#{Date.to_iso8601(today())}.md")
  end
end
