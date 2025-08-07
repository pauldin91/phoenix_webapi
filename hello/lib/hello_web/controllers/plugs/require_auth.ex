defmodule Hello.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  def init(params), do: params

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: "/topics")
      |> halt()
    end
  end
end
