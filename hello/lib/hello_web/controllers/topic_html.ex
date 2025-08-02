defmodule HelloWeb.TopicHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use HelloWeb, :html

  embed_templates("topic_html/*")
end
