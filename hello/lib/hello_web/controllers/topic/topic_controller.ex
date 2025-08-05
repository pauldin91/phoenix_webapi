defmodule HelloWeb.TopicController do
  use HelloWeb, :controller
  alias Hello.Topics.Topic
  alias Hello.Repo

  def new(conn, params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    render(conn, :show, topic: topic)
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id)
    |> Repo.delete()

    conn
    |> put_flash(:info, "Topic deleted")
    |> redirect(to: ~p"/topics")
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, :edit, changeset: changeset, topic: topic)
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: ~p"/topics")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    changeset =
      Repo.get(Topic, topic_id)
      |> Topic.changeset(topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: ~p"/topics")

      {:error, topic} ->
        render(conn, :edit, changeset: changeset)
    end
  end
end
