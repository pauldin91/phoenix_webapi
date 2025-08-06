defmodule Hello.User do
  use Hello.Web, :model

  schema "users" do
    add(:email, :string)
    add(:provider, :string)
    add(:token, :string)
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
