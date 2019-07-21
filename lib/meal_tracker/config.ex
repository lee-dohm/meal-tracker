defmodule MealTracker.Config do
  @moduledoc """
  Represents the configuration of the meal tracker application.
  """

  defstruct [:root]

  @doc """
  Reads the configuration from `~/.meal-tracker`.
  """
  def read do
    lines =
      config_path()
      |> safe_read()
      |> String.split("\n")

    read_lines(%__MODULE__{}, lines)
  end

  defp config_path do
    "~/.meal-tracker"
    |> Path.expand()
  end

  defp read_line(struct, "root: " <> path), do: %__MODULE__{struct | root: Path.expand(path)}

  defp read_line(struct, _line), do: struct

  defp read_lines(struct, lines) do
    Enum.reduce(lines, struct, fn line, acc_struct -> read_line(acc_struct, line) end)
  end

  defp safe_read(path) do
    if File.exists?(path) do
      File.read!(path)
    else
      ""
    end
  end
end
