defmodule HelloWeb.TopicController do
  use HelloWeb, :controller
  alias Hello.Topic
  alias Hello.Repo

  plug(Hello.Plugs.RequireAuth when action not in [:index])
  plug :check_post_owner when action in [:update, :edit, :delete]

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def index(conn, _params) do
    topics = Repo.all_by(Topic, user_id: conn.assigns.user.id) |> Repo.preload(:user)
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
    changeset =
      conn.assigns.user
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic)

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
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: ~p"/topics")

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def check_post_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id) ==
         conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You dont own it")
      |> redirect(to: ~p"/topics")
      |> halt()
    end
  end
end
