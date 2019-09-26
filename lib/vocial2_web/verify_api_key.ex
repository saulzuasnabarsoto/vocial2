defmodule Vocial2Web.VerifyApiKey do
  import Plug.Conn, only: [halt: 1, put_status: 2]
  import Phoenix.Controller, only: [put_view: 2, render: 2]

  alias Vocial2.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    is_valid_api_key?(conn)
    |> handle_conn(conn)
  end

  def is_valid_api_key?(conn) do
    with {:ok, header} <- fetch_authorization_header(conn),
         {:ok, decoded_header} <- decode_authorization_header(header),
         [username, api_key] = String.split(decoded_header, ":")
    do
      Accounts.verify_api_key(username, api_key)
    else
      _ -> false
    end
  end

  def fetch_authorization_header(conn) do
    conn.req_headers
    |> Enum.into(%{})
    |> Map.fetch("authorization")
  end

  def decode_authorization_header(auth_header) do
    [type, key] = String.split(auth_header, " ")
    case String.downcase(type) do
      "basic" -> {:ok, key}
      _ -> {:error, "Invalid Authorization Header Format"}
    end
  end

  def invalid_api_key(conn) do
    conn
    |> put_status(401)
    |> put_view(Vocial2Web.ErrorView)
    |> render("invalid_api_key.json")
    |> halt()
  end

  def handle_conn(true, conn), do: conn
  def handle_conn(_, conn), do: invalid_api_key(conn)
end
