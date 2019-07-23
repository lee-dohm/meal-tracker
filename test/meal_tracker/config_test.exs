defmodule MealTracker.ConfigTest do
  use ExUnit.Case

  alias MealTracker.Config

  import Support.TempUtils

  def write_config(path, text), do: File.write!(path, text)

  setup do
    path = temp_path()

    on_exit(fn ->
      if File.exists?(path) do
        File.rm!(path)
      end
    end)

    {:ok, path: path}
  end

  describe "read" do
    test "returns the default when no file exists", context do
      config = Config.read(context.path)

      assert config.root == "~/meal-tracker"
    end

    test "returns the default when an empty file exists", context do
      write_config(context.path, "")
      config = Config.read(context.path)

      assert config.root == "~/meal-tracker"
    end

    test "returns the appropriate values when a file exists", context do
      write_config(context.path, "root: ~/foo/bar/baz\n")
      config = Config.read(context.path)

      assert config.root == "~/foo/bar/baz"
    end

    test "trims excess whitespace from values", context do
      write_config(context.path, "root: \t~/foo/bar/baz     \n")
      config = Config.read(context.path)

      assert config.root == "~/foo/bar/baz"
    end
  end

  describe "root" do
    test "returns the expanded path", context do
      write_config(context.path, "root: ~/foo/bar/baz\n")
      config = Config.read(context.path)

      assert Config.root(config) == Path.expand("~/foo/bar/baz")
    end
  end
end
