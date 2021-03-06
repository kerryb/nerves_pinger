defmodule UI.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ui,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {UI.Application, []},
      extra_applications: [:logger, :runtime_tools, :httpoison]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:gettext, "~> 0.11"},
      {:httpoison, "~> 1.0"},
      {:jason, "~> 1.0"},
      {:phoenix, "~> 1.4.0", override: true},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:phoenix_live_view, github: "phoenixframework/phoenix_live_view"},
      {:phoenix_pubsub, "~> 1.0"},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
