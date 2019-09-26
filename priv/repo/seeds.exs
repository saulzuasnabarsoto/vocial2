# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Vocial2.Repo.insert!(%Vocial2.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Vocial2.Repo
alias Vocial2.Votes
alias Vocial2.Votes.Poll
alias Vocial2.Votes.Option
alias Vocial2.Votes.VoteRecord
alias Vocial2.Votes.Image
alias Vocial2.Votes.Message
alias Vocial2.Accounts
alias Vocial2.Accounts.User

Repo.delete_all(Option)
Repo.delete_all(VoteRecord)
Repo.delete_all(Image)
Repo.delete_all(Message)
Repo.delete_all(Poll)
Repo.delete_all(User)

user_attrs = %{ username: "testuser", email: "testuser@test.local", active: true, password: "test1234"}
user = case Accounts.create_user(user_attrs) do
  {:ok, user} ->
    IO.puts("User created successfully!")
    user
  {:error, changeset} ->
    IO.puts("Failed to create user account!")
    IO.inspect(changeset)
    nil
end

if user do
  polls = [
    %{ title: "Test Poll 1", options: ["Choice 1", "Choice 2", "Choice 3"] },
    %{ title: "Test Poll 2", options: ["Choice 1", "Choice 2", "Choice 3"] },
    %{ title: "Test Poll 3", options: ["Choice 1", "Choice 2", "Choice 3"] },
    %{ title: "Test Poll 4", options: ["Choice 1", "Choice 2", "Choice 3"] },
    %{ title: "Test Poll 5", options: ["Choice 1", "Choice 2", "Choice 3"] }
  ]
  Enum.each(polls, fn p ->
    case Votes.create_poll_with_options(%{title: p.title, user_id: user.id}, p.options) do
      {:ok, _poll} ->
        IO.puts("Poll created successfully!")
      {:error, changeset} ->
        IO.puts("Failed to create poll!")
        IO.inspect(changeset)
    end
  end)
end
