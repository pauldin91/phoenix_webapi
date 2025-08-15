defmodule Hello.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  schema "comments" do
    field :content, :string
    belongs_to :user, Hello.User
    belongs_to :topic, Hello.Topic
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
