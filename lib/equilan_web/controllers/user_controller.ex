defmodule EquilanWeb.UserController do
  use EquilanWeb, :controller

  alias Equilan.Model
  alias Equilan.Model.User

  action_fallback EquilanWeb.FallbackController

  def index(conn, _params) do
    users = Model.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Model.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Model.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Model.get_user!(id)

    with {:ok, %User{} = user} <- Model.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Model.get_user!(id)
    with {:ok, %User{}} <- Model.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
