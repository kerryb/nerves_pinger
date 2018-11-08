defmodule Firmware.MixProject do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  def project do
    [
      app: :firmware,
      version: "0.1.0",
      elixir: "~> 1.6",
      target: @target,
      archives: [nerves_bootstrap: "~> 1.0"],
      deps_path: "deps/#{@target}",
      build_path: "_build/#{@target}",
      lockfile: "mix.lock.#{@target}",
      start_permanent: Mix.env() == :prod,
      aliases: [loadconfig: [&bootstrap/1]],
      deps: deps()
    ]
  end

  # Starting nerves_bootstrap adds the required aliases to Mix.Project.config()
  # Aliases are only added if MIX_TARGET is set.
  def bootstrap(args) do
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Firmware.Application, []},
      extra_applications: [:logger, :runtime_tools, :httpotion]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpotion, "~> 3.1"},
      {:nerves, "~> 1.3", runtime: false},
      {:nerves_firmware, "~> 0.4"},
      {:ring_logger, "~> 0.6"},
      {:pinger, path: "../pinger"}
    ] ++ deps(@target)
  end

  # Specify target specific dependencies
  defp deps("host"), do: []

  defp deps(target) do
    [
      {:shoehorn, "~> 0.4"},
      {:nerves_runtime, "~> 0.6"},
      {:nerves_init_gadget, "~> 0.4"}
    ] ++ system(target)
  end

  defp system("rpi"), do: [{:nerves_system_rpi, "~> 1.2", runtime: false}]
  defp system("rpi0"), do: [{:nerves_system_rpi0, "~> 1.2", runtime: false}]
  defp system("rpi2"), do: [{:nerves_system_rpi2, "~> 1.2", runtime: false}]
  defp system("rpi3"), do: [{:nerves_system_rpi3, "~> 1.2", runtime: false}]
  defp system("bbb"), do: [{:nerves_system_bbb, "~> 1.2", runtime: false}]
  defp system("ev3"), do: [{:nerves_system_ev3, "~> 1.2", runtime: false}]
  defp system("qemu_arm"), do: [{:nerves_system_qemu_arm, "~> 1.0", runtime: false}]
  defp system("x86_64"), do: [{:nerves_system_x86_64, "~> 1.2", runtime: false}]
  defp system(target), do: Mix.raise("Unknown MIX_TARGET: #{target}")
end
