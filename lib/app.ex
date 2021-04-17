defmodule App do
  use Application

  def start(_type, _args) do
    unless Mix.env == :prod do
      Dotenv.load
      Mix.Task.run("loadconfig")
    end

    bot_name = Application.get_env(:app, :bot_name)
    port = String.to_integer(Application.get_env(:app, :port))

    unless String.valid?(bot_name) do
      IO.warn("""
      Env not found Application.get_env(:app, :bot_name)
      This will give issues when generating commands
      """)
    end

    if bot_name == "" do
      IO.warn("An empty bot_name env will make '/anycommand@' valid")
    end

    Nadia.set_webhook([url: "#{System.get_env("DOMAIN")}/bot/1e4abe972553c1f2994e9ce34093bcb07f6dc893"])

    children = [
      App.Matcher,
      Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: App.Server, options: [port: port])
    ]

    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
