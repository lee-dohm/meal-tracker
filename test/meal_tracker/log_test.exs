defmodule MealTracker.LogTest do
  use ExUnit.Case

  alias MealTracker.{FoodItem, Log}

  def temp_path do
    dir = System.tmp_dir!()
    filename = "#{System.unique_integer([:positive])}.md"

    Path.join(dir, filename)
  end

  def today do
    NaiveDateTime.utc_now()
    |> NaiveDateTime.to_date()
  end

  describe "new" do
    test "creates an empty log with today's date" do
      log = Log.new()

      assert log.date == today()
      assert log.entries == []
    end
  end

  describe "add_entry" do
    test "adds an entry to the log" do
      entry = FoodItem.parse("Apple")

      log =
        Log.new()
        |> Log.add_entry(entry)

      assert log.date == today()
      assert log.entries == [entry]
    end
  end

  describe "read" do
    setup do
      path = temp_path()

      on_exit(fn ->
        if File.exists?(path) do
          File.rm!(path)
        end
      end)

      {:ok, path: path}
    end

    test "reads the log from a file", context do
      content = """
      # 2019-07-21

      * Apple
      """

      File.write!(context.path, content)
      {:ok, log} = Log.read(context.path)

      assert log.date == NaiveDateTime.to_date(~N[2019-07-21 00:00:00])
      assert log.entries == [FoodItem.parse("Apple")]
    end

    test "orders entries newest first", context do
      content = """
      # 2019-07-21

      * Apple
      * Beer
      * Cracker
      """

      File.write!(context.path, content)
      {:ok, log} = Log.read(context.path)

      assert log.date == NaiveDateTime.to_date(~N[2019-07-21 00:00:00])

      assert log.entries == [
               FoodItem.parse("Cracker"),
               FoodItem.parse("Beer"),
               FoodItem.parse("Apple")
             ]
    end
  end

  describe "write" do
    setup do
      path = temp_path()

      on_exit(fn ->
        if File.exists?(path) do
          File.rm!(path)
        end
      end)

      {:ok, path: path}
    end

    test "saves the log to a file", context do
      entry = FoodItem.parse("Apple")

      Log.new()
      |> Log.add_entry(entry)
      |> Log.write(context.path)

      assert File.exists?(context.path)

      assert File.read!(context.path) ==
               """
               # #{Date.to_iso8601(today())}

               * 1x Apple
               """
    end

    test "saves the entries in the order they were added", context do
      Log.new()
      |> Log.add_entry(FoodItem.parse("Apple"))
      |> Log.add_entry(FoodItem.parse("Beer"))
      |> Log.add_entry(FoodItem.parse("Cracker"))
      |> Log.write(context.path)

      assert File.exists?(context.path)

      assert File.read!(context.path) ==
               """
               # #{Date.to_iso8601(today())}

               * 1x Apple
               * 1x Beer
               * 1x Cracker
               """
    end
  end
end
