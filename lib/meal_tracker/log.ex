defmodule MealTracker.Log do
  @moduledoc """
  Represents a daily log.
  """

  alias MealTracker.FoodItem

  defstruct [:date, entries: []]

  @doc """
  Creates an empty log with today's date.
  """
  def new do
    %__MODULE__{date: NaiveDateTime.utc_now() |> NaiveDateTime.to_date()}
  end

  @doc """
  Adds an entry to the log.
  """
  def add_entry(log, entry) do
    %__MODULE__{log | entries: [entry | log.entries]}
  end

  @doc """
  Reads a log from the given `path`.
  """
  def read(path) do
    lines =
      path
      |> File.read!()
      |> String.split("\n")

    {:ok, parse_lines(%__MODULE__{}, lines)}
  end

  @doc """
  Writes the `log` to the given `path`.
  """
  def write(log, path) do
    content = """
    # #{Date.to_iso8601(log.date)}

    #{write_entries(log)}
    """

    File.write(path, content)
  end

  defp parse_date(log, "# " <> date), do: %__MODULE__{log | date: Date.from_iso8601!(date)}

  defp parse_item(log, "* " <> item), do: add_entry(log, FoodItem.parse(item))

  defp parse_line(log, line) do
    cond do
      String.starts_with?(line, "# ") -> parse_date(log, line)
      String.starts_with?(line, "* ") -> parse_item(log, line)
      true -> log
    end
  end

  defp parse_lines(log, lines) do
    Enum.reduce(lines, log, fn line, acc_log -> parse_line(acc_log, line) end)
  end

  defp write_entries(log) do
    log.entries
    |> Enum.reverse()
    |> Enum.map(fn entry -> "* #{FoodItem.to_string(entry)}" end)
    |> Enum.join("\n")
  end
end
