defmodule MealTracker.Config do
  @moduledoc """
  Represents the configuration of the meal tracker application.
  """

  defstruct root: "~/meal-tracker"

  @doc """
  Reads the configuration from `~/.meal-tracker`.
  """
  def read, do: read(config_path())

  @doc false
  def read(path) do
    lines =
      path
      |> safe_read()
      |> String.split("\n")

    read_lines(%__MODULE__{}, lines)
  end

  @doc """
  Gets the directory in which to store all of the application's data.
  """
  def root do
    read()
    |> root()
  end

  @doc false
  def root(%__MODULE__{} = config) do
    config
    |> Map.get(:root)
    |> Path.expand()
  end

  defp config_path do
    "~/.meal-tracker"
    |> Path.expand()
  end

  defp read_line(struct, "root:" <> path), do: %__MODULE__{struct | root: String.trim(path)}

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
