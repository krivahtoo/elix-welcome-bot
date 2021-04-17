use Mix.Config

config :app,
  bot_name: "gwelcomebot",
  port: System.get_env("PORT"),
  ecto_repos: [App.Repo]

config :nadia,
  token: {:system, "TOKEN", ""}

import_config "#{Mix.env}.exs"
