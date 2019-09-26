defmodule Vocial2Web.PageController do
  use Vocial2Web, :controller

  alias Vocial2.Votes
  alias Vocial2.ChatCache

  def index(conn, _params) do
    messages = Votes.list_lobby_messages() |> Enum.reverse()

    render(conn, "index.html", messages: messages)
  end

  def history(conn, _params) do
    render conn, "history.html", logs: ChatCache.lookup()
  end
end
