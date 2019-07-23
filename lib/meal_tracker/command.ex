defmodule MealTracker.Command do
  @moduledoc """
  Defines the interface and utilities for the command-line sub-commands.

  ## Attributes

  There are attributes that integrate a command module with the rest of the system:

  * `@shortdoc` - makes the command public with a short description that shows up in `track help`

  ## Documentation

  Users can read the documentation for a command by executing `track help command_name`. The
  documentation that will be shown is the `@moduledoc` of the command's module.
  """

  @doc """
  A command needs to implement `run` which receives a list of command-line args.
  """
  @callback run(command_line_args :: [binary]) :: any

  @doc false
  defmacro __using__(_opts) do
    quote do
      Enum.each(
        MealTracker.Command.supported_attributes(),
        &Module.register_attribute(__MODULE__, &1, persist: true)
      )

      @behaviour MealTracker.Command

      import MealTracker.DateUtils
      import MealTracker.PathUtils
    end
  end

  @doc false
  def supported_attributes, do: [:shortdoc]
end
