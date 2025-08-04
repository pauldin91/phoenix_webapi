defmodule Hello.Topics.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Hello.Repo

  schema "topics" do
    field(:title, :string)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end

  def list_topics do
    Repo.all(Topic)
  end
end
