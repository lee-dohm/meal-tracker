defmodule MealTracker.MixProject do
  use Mix.Project

  def project do
    [
      app: :meal_tracker,
      version: "0.1.2",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      docs: docs(),
      escript: escript()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      "escript.build": ["touch_version", "escript.build"],
      "escript.install": ["touch_version", "escript.install"],
      touch_version: &touch_version/1
    ]
  end

  defp deps do
    [
      {:ex_doc, "> 0.0.0", only: [:dev, :test], runtime: false},
      {:version_tasks, "~> 0.11.3", only: :dev}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "LICENSE.md"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp escript do
    [
      main_module: MealTracker.CLI,
      name: "track"
    ]
  end

  defp touch_version(_) do
    path = Path.expand("lib/meal_tracker.ex", __DIR__)

    System.cmd("touch", [path])
  end
end
