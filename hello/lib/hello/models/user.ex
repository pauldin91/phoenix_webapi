defmodule Hello.User do
  use Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query, warn: false

  alias Hello.Topics.Topic

  schema "users" do
    field(:email, :string)
    field(:provider, :string)
    field(:token, :string)
    has_many(:topics, Topic)
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
