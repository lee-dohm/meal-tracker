defmodule MealTracker.Commands.Edit do
  @moduledoc """
  Opens a daily meal log in your editor.

  ```
  track edit [options]
  ```

  Defaults to the current day's log if no options are given.

  ## Command-line options

  * `--for DATE` - Opens the log for the given date

  `DATE` must be given in ISO 8601 format, ex: `2019-07-21`.
  """

  use MealTracker.Command

  @shortdoc "Opens meal log in editor"

  def run(args) do
    args
    |> parse_args()
    |> edit_log()
  end

  defp edit_log({opts, _, _}) do
    date = Keyword.get(opts, :for, today())
    path = log_path(date)
    command_text = "#{System.get_env("EDITOR")} #{path}"
    [command | args] = OptionParser.split(command_text)

    System.cmd(command, args)
  end

  defp parse_args(args) do
    OptionParser.parse(args, strict: [for: :string])
  end
end
