defmodule AccountingSystemWeb.ConfigurationComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="m-16"> Configuration </div>
    """
  end

end
