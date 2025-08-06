defmodule HelloWeb.AuthController do
  use HelloWeb, :controller
  plug(Ueberauth)

  alias Hello.User

  def callback(%{assigns: %{ueberauth_failure: %Ueberauth.Failure{}}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate")
    |> redirect(to: ~p"/")
  end

  def callback(%{assigns: %{ueberauth_auth: %Ueberauth.Auth{} = auth}} = conn, _params) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)

    conn
    # |> renew_session()
    # |> put_session(:user_id, user.id)
    |> redirect(to: ~p"/")
  end
end
