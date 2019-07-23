defmodule MealTracker.DateUtilsTest do
  use ExUnit.Case

  alias MealTracker.DateUtils

  describe "today" do
    test "returns today as a date" do
      today =
        :calendar.local_time()
        |> NaiveDateTime.from_erl!()
        |> NaiveDateTime.to_date()

      assert DateUtils.today() == today
    end
  end
end
