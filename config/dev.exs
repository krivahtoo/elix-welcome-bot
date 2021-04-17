use Mix.Config

config :app, App.Repo,
  database: "bot",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"
