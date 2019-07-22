defmodule MealTracker.Commands.Add do
  @moduledoc """
  Handles the `track add` command.
  """

  alias MealTracker.{FoodItem, Helper, Log}

  import MealTracker.PathUtils

  def run(args) do
    args
    |> parse_args()
    |> read_or_create_log()
    |> add_entry()
    |> write_log()
  end

  defp add_entry({log, {_, rest, _} = options}) do
    entry =
      rest
      |> Enum.join(" ")
      |> FoodItem.parse()

    {Log.add_entry(log, entry), options}
  end

  defp parse_args(args) do
    options = OptionParser.parse(args, strict: [for: :string])

    {nil, options}
  end

  defp read_or_create_log({_, {opts, _, _} = options}) do
    date = Keyword.get(opts, :for, Helper.today())
    path = log_path(date)

    if File.exists?(path) do
      {:ok, log} = Log.read(path)

      {log, options}
    else
      {Log.new(date), options}
    end
  end

  defp write_log({log, {opts, _, _}}) do
    date = Keyword.get(opts, :for, Helper.today())

    Log.write(log, log_path(date))
  end
end
