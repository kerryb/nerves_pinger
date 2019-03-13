defmodule Updater.MixProject do
  use Mix.Project

  def project do
    [
      app: :updater,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpotion, :poison],
      mod: {Updater.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpotion, "~> 3.1"},
      {:poison, "~> 3.1"}
    ]
  end
end
