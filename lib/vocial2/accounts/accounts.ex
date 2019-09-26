defmodule Vocial2.Accounts do
  import Ecto.Query, warn: false

  alias Vocial2.Repo
  alias Vocial2.Accounts.User

  def list_users, do: Repo.all(User)

  def new_user, do: User.changeset(%User{}, %{})

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
  def get_user(id), do: Repo.get(User, id)

  def get_user_by_username(username) do
    Repo.get_by(User, username: username)
  end

  def generate_api_key(user) do
    user
    |> User.changeset(%{api_key: random_string(32)})
    |> Repo.update()
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  def verify_api_key(username, api_key) do
    case Repo.get_by(User, username: username, api_key: api_key) do
      nil -> false
      _user -> true
    end
  end

end
