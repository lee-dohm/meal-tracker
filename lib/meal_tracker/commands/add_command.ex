defmodule MealTracker.Commands.AddCommand do
  alias MealTracker.{FoodItem, Helper, Log}

  def run(options) do
    entry =
      options
      |> Enum.join(" ")
      |> FoodItem.parse()

    read_or_create_today()
    |> Log.add_entry(entry)
    |> write_today()
  end

  defp read_or_create_today do
    path = Helper.today_path()

    if File.exists?(path) do
      {:ok, log} = Log.read(path)

      log
    else
      Log.new()
    end
  end

  defp write_today(log) do
    Log.write(log, Helper.today_path())
  end
end
