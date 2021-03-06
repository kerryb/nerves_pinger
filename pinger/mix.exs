defmodule Pinger.MixProject do
  use Mix.Project

  def project do
    [
      app: :pinger,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpotion, :poison],
      mod: {Pinger.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpotion, "~> 3.1"},
      {:poison, "~> 3.1"},
      {:timex, "~> 3.5"}
    ]
  end
end
