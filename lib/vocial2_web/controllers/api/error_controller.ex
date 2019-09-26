defmodule Vocial2Web.Api.ErrorController do
  use Vocial2Web, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(Vocial2Web.ErrorView)
    |> render("404.json")
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> put_view(Vocial2Web.ErrorView)
    |> render("500.json")
  end
end
