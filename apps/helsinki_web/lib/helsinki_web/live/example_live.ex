defmodule AccountingSystemWeb.ExampleLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>LiveView is ready</h1>
    """
  end
end
