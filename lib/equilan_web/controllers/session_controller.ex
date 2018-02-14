defmodule EquilanWeb.SessionController do
  use EquilanWeb, :controller

  def index(conn, _params) do
    conn
    |> json(%{status: "ok"})
  end
end
