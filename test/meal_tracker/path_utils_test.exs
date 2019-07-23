defmodule MealTracker.PathUtilsTest do
  use ExUnit.Case

  alias MealTracker.{Config, PathUtils}

  setup do
    {:ok, blank_config: %Config{}}
  end

  describe "log_path" do
    test "returns the correct path when given a string", context do
      path = PathUtils.log_path("2019-07-21", context.blank_config)

      assert path == Path.expand("~/meal-tracker/2019-07-21.md")
    end

    test "returns the correct path when given a date value", context do
      path = PathUtils.log_path(~D[2019-07-21], context.blank_config)

      assert path == Path.expand("~/meal-tracker/2019-07-21.md")
    end

    test "returns a path in the configured root" do
      path = PathUtils.log_path("2019-07-21", %Config{root: "~/foo/bar/baz"})

      assert path == Path.expand("~/foo/bar/baz/2019-07-21.md")
    end
  end
end
