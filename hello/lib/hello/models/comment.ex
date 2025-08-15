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
    |> cast(params, [:content, :user_id, :topic_id])
    |> validate_required([:content, :user_id, :topic_id])
  end
end
