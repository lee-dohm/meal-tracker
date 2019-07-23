defmodule MealTracker.Commands.Add do
  @moduledoc """
  Adds an entry to a daily food log.

  ```
  track add [options] ENTRY
  ```

  By default, it adds the entry to the food log for the current date.

  ## Command-line options

  * `--for DATE` - Allows adding the entry to the food log for a given date
  """

  alias MealTracker.{FoodItem, Log}

  import MealTracker.DateUtils
  import MealTracker.PathUtils

  @doc false
  def run(args) do
    args
    |> parse_args()
    |> read_or_create_log()
    |> add_entry()
    |> write_log()
  end

  defp add_entry({log, {_, rest, _} = options}) do
    {Log.add_entry(log, FoodItem.parse(rest)), options}
  end

  defp parse_args(args) do
    options = OptionParser.parse(args, strict: [for: :string])

    {nil, options}
  end

  defp read_or_create_log({_, {opts, _, _} = options}) do
    date = Keyword.get(opts, :for, today())
    path = log_path(date)

    case Log.read(path) do
      {:error, :enoent} -> {Log.new(date), options}
      {:ok, log} -> {log, options}
    end
  end

  defp write_log({log, {opts, _, _}}) do
    date = Keyword.get(opts, :for, today())

    Log.write(log, log_path(date))
  end
end
