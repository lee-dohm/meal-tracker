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

    test "reads 'Apple' as one apple item" do
      item = FoodItem.parse("Apple")

      assert item.name == "Apple"
      assert item.quantity == 1
      assert item.unit == :item
    end

    test "reads '355 milliliter Pepsi' as 355 milliliters of Pepsi" do
      item = FoodItem.parse("355 milliliter Pepsi")

      assert item.name == "Pepsi"
      assert item.quantity == 355
      assert item.unit == :milliliter
    end

    test "reads '355 milliliters Pepsi' as 355 milliliters of Pepsi" do
      item = FoodItem.parse("355 milliliters Pepsi")

      assert item.name == "Pepsi"
      assert item.quantity == 355
      assert item.unit == :milliliter
    end

    test "reads '355 milliliters of Pepsi' as 355 milliliters of Pepsi" do
      item = FoodItem.parse("355 milliliters of Pepsi")

      assert item.name == "Pepsi"
      assert item.quantity == 355
      assert item.unit == :milliliter
    end
  end
end
