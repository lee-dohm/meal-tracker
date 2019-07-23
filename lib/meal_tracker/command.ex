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

  @doc """
  Converts a command name to the matching module name.
  """
  def command_to_module_name(command) do
    command
    |> String.replace("-", "_")
    |> Macro.camelize()
  end

  @doc """
  Converts a module name into the matching command name.
  """
  def module_name_to_command(module, nesting \\ 2)

  def module_name_to_command(atom, nesting) when is_atom(atom) do
    module_name_to_command(inspect(atom), nesting)
  end

  def module_name_to_command(module, nesting) do
    module
    |> String.split(".")
    |> Enum.drop(nesting)
    |> Enum.map_join(".", &dasherize/1)
  end

  defp dasherize(<<h, t::binary>>) do
    <<to_lower_char(h)>> <> do_dasherize(t, h)
  end

  defp dasherize(""), do: ""

  defp do_dasherize(<<h, t, rest::binary>>, _)
       when h >= ?A and h <= ?Z and not (t >= ?A and t <= ?Z) and t != ?- do
    <<?-, to_lower_char(h), t>> <> do_dasherize(rest, t)
  end

  defp do_dasherize(<<h, t::binary>>, prev)
       when h >= ?A and h <= ?Z and not (prev >= ?A and prev <= ?Z) and prev != ?- do
    <<?-, to_lower_char(h)>> <> do_dasherize(t, h)
  end

  defp do_dasherize(<<h, t::binary>>, _) do
    <<to_lower_char(h)>> <> do_dasherize(t, h)
  end

  defp do_dasherize(<<>>, _) do
    <<>>
  end

  defp to_lower_char(char) when char >= ?A and char <= ?Z, do: char + 32
  defp to_lower_char(char), do: char
end
