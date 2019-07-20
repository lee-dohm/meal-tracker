defmodule MealTracker.FoodItemTest do
  use ExUnit.Case

  alias MealTracker.FoodItem

  describe "parse/1" do
    test "reads '5x Apple' as five apple items" do
      item = FoodItem.parse("5x Apple")

      assert item.name == "Apple"
      assert item.quantity == 5
      assert item.unit == :item
    end
  end
end
