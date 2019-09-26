defmodule Vocial2Web.PollsChannel do
  use Vocial2Web, :channel
  alias Vocial2.Accounts

  def join("polls:" <> _poll_id, %{"remote_ip" => remote_ip}, socket) do
    socket = assign(socket, :remote_ip, remote_ip)
    {:ok, socket}
  end

  def handle_in("ping", _payload, socket) do
    user = Accounts.get_user(7)
    broadcast(socket, "pong", %{message: user.email})
    {:reply, {:ok, %{message: user.email}}, socket}
  end

  def handle_in("vote", %{"option_id" => option_id}, %{assigns: %{remote_ip: remote_ip}}=socket) do
    with {:ok, option} <- Vocial2.Votes.vote_on_option(option_id, remote_ip) do
      broadcast(socket, "new_vote", %{"option_id" => option_id, "votes" => option.votes})
      {:reply, {:ok, %{"option_id" => option.id, "votes" => option.votes}}, socket}
    else
      {:error, _} ->
        {:reply, {:error, %{message: "Failed to vote for option!"}}, socket}
    end
  end
end
