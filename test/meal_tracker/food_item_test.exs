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

    test "accepts an array of strings by joining them with spaces" do
      item = FoodItem.parse(~W[355 milliliters of Pepsi])

      assert item.name == "Pepsi"
      assert item.quantity == 355
      assert item.unit == :milliliter
    end
  end

  describe "to_string/1" do
    test "formats a single food item" do
      text = FoodItem.to_string(%FoodItem{name: "Apple"})

      assert text == "1x Apple"
    end

    test "formats multiple food items" do
      text = FoodItem.to_string(%FoodItem{name: "Apple", quantity: 5})

      assert text == "5x Apple"
    end

    test "formats food items with units" do
      text = FoodItem.to_string(%FoodItem{name: "Pepsi", quantity: 355, unit: :milliliter})

      assert text == "355 milliliter Pepsi"
    end
  end
end
