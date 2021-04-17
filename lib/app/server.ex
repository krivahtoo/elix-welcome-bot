defmodule App.Server do
  use Plug.Router

  if Mix.env() == :dev do
    use Plug.Debugger
  end

  use Plug.ErrorHandler
  require Logger
  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  # Simple GET Request handler for path /
  get "/" do
    send_resp(conn, 200, "Ok")
  end

  # Replace with unique string
  post "/bot/1e4abe972553c1f2994e9ce34093bcb07f6dc893" do
    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body, keys: :atoms)
    result = Nadia.Parser.parse_result([body], "getUpdates")

    {:ok, result}
    |> process_messages

    send_resp(conn, 200, "Done")
  end

  # "Default" route that will get called when no other route is matched
  match _ do
    send_resp(conn, 404, "not found")
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end

  # Helpers

  defp process_messages({:ok, [nil]}), do: -1

  defp process_messages({:ok, results}) do
    results
    |> Enum.map(fn %{update_id: id} = message ->
      message
      |> process_message

      id
    end)
    |> List.last()
  end

  defp process_message(message) do
    try do
      App.Matcher.match(message)
    rescue
      err in MatchError ->
        Logger.log(:warn, "Errored with #{err} at #{Poison.encode!(message)}")
    end
  end
end
