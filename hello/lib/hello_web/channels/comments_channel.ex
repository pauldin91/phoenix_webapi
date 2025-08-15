defmodule HelloWeb.CommentsChannel do
  use HelloWeb, :channel

  alias Hello.Repo
  alias Hello.Comment

  @impl true
  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)

    topic =
      Topic
      |> Repo.get(topic_id)
      |> Repo.preload(comments: [:user])

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  @impl true
  def handle_in(name, payload, socket) do
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    changeset =
      topic
      |> Ecto.build_assoc(:comments, user_id: user_id)
      |> Comment.changeset(%{content: payload})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}

      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
