defmodule Hello.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  schema "topics" do
    field(:title, :string)
    belongs_to :user, Hello.User
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
