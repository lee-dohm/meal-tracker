defmodule MealTracker.DateUtils do
  @moduledoc """
  Utilities for handling dates.
  """

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
end
