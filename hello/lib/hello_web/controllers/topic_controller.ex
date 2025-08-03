defmodule HelloWeb.TopicController do
  use HelloWeb, :controller
  alias Hello.Topics.Topic

  def new(conn, params) do
    changset = Topic.changeset(%Topic{}, %{})
    render(conn, :new, changeset: changeset)
  end
end
