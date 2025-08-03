defmodule HelloWeb.TopicController do
  use HelloWeb, :controller
  alias Hello.Topics.Topic

  def new(conn, params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
  end
end
