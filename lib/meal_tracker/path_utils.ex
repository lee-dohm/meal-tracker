defmodule MealTracker.PathUtils do
  @moduledoc """
  Utility functions for finding the correct file system paths.
  """

  alias MealTracker.Config

  @doc """
  Gets the log path for a given `date`.

  ## Examples

  When given the date in ISO 8601 text form:

  ```
  iex> MealTracker.PathUtils.log_path("2019-07-21")
  "/Users/username/meal-tracker/2019-07-21.md"
  ```

  When given the date as a `Date.t()`:

  ```
  iex> MealTracker.PathUtils.log_path(~D[2019-07-21])
  "/Users/username/meal-tracker/2019-07-21.md"
  ```
  """
  @spec log_path(Date.t() | String.t(), Config.t()) :: Path.t()
  def log_path(date, config \\ Config.read())

  def log_path(text, config) when is_binary(text) do
    with {:ok, date} <- Date.from_iso8601(text) do
      log_path(date, config)
    end
  end

  def log_path(%Date{} = date, config) do
    Path.join(Config.root(config), Date.to_iso8601(date) <> ".md")
  end
end
