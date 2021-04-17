use Mix.Config

config :app, App.Repo, url: System.get_env("DATABASE_URL")
