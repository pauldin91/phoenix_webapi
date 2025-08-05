defmodule HelloWeb.TopicController do
  use HelloWeb, :controller
  alias Hello.Topics.Topic
  alias Hello.{Repo}

  def new(conn, params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, :index, topics: topics)
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info,"Topic Created")
        |> redirect(to: ~p"/topics")

      {:error, changeset} ->
        render(conn, :new,changeset: changeset)
    end
  end
end
