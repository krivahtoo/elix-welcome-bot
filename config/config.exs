use Mix.Config

config :app,
  bot_name: "",
  # port: {:system, "PORT", 3000}
  port: System.get_env("PORT"),
  ecto_repos: [App.Repo]

config :nadia,
  token: {:system, "TOKEN", ""}

config :app, App.Repo,
  database: "bot",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"

import_config "#{Mix.env}.exs"
