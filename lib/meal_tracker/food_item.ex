defmodule MealTracker.FoodItem do
  @moduledoc """
  Represents a food item in a meal log.

  ## Text Formats

  This module exists to translate food items between the structure representation and textual
  representations. In the patterns below "Food name" represents the name of the food, "nx"
  represents the number (n) of items of that food, and "n unit" represents the number (n) of unit of
  the food such as "355 milliliter Pepsi".

  * `Food name` (equivalent to `1x Food name`)
  * `nx Food name`
  * `n unit Food name`
  """

  defstruct [:name, quantity: 1, unit: :item]

  @item_quantity_pattern ~r/^(?<quantity>\d+(\.\d+)?)x (?<name>.+)$/

  @doc """
  Parses a food item entry into the `MealTracker.FoodItem` struct.
  """
  def parse(text) do
    cond do
      captures = Regex.named_captures(@item_quantity_pattern, text) -> parse_item_quantity(captures)
    end
  end

  defp parse_float({quantity, ""}, _), do: quantity

  defp parse_integer({quantity, ""}, _), do: quantity
  defp parse_integer(_, text), do: parse_float(Float.parse(text), text)

  defp parse_item_quantity(captures) do
    %__MODULE__{name: captures["name"], quantity: parse_number(captures["quantity"])}
  end

  defp parse_number(text), do: parse_integer(Integer.parse(text), text)
end
