defmodule App.Mixfile do
  use Mix.Project

  def project do
    [app: :app,
     version: "0.1.0",
     elixir: "~> 1.3",
     default_task: "server",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     aliases: aliases()]
  end

  def application do
    [applications: app_list(Mix.env),
     mod: {App, []}]
  end

  defp deps do
    [
      {:nadia, "~> 0.6.0"},
      {:poison, "~> 3.1"},
      {:plug_cowboy, "~> 2.0"},
      {:dotenv, "~> 3.0.0", only: [:dev, :test]},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end

  defp aliases do
    [server: "run --no-halt"]
  end

  defp app_list(:dev), do: [:dotenv | app_list()]
  defp app_list(_), do: app_list()
  defp app_list, do: [:logger, :nadia, :cowboy, :plug, :poison, :ecto, :ecto_sql]
end
