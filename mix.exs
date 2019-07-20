defmodule MealTracker.MixProject do
  use Mix.Project

  def project do
    [
      app: :meal_tracker,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
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
end
