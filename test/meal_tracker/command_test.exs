defmodule MealTracker.CommandTest do
  use ExUnit.Case

  alias MealTracker.Command

  describe "module_name_to_command" do
    test "converts a simple module name to a command" do
      assert Command.module_name_to_command("MealTracker.Command.Test") == "test"
    end

    test "converts a camel-cased module name to a command" do
      assert Command.module_name_to_command("MealTracker.Command.FooBar") == "foo-bar"
    end

    test "converts a module name atom to a command" do
      assert Command.module_name_to_command(MealTracker.Command.FooBar) == "foo-bar"
    end
  end

  describe "command_to_module_name" do
    test "converts a simple command to a module name" do
      assert Command.command_to_module_name("foo") == "Foo"
    end

    test "converts a compound command to a module name" do
      assert Command.command_to_module_name("foo-bar") == "FooBar"
    end
  end
end
