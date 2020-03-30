defmodule AccountingSystemWeb.ActivesComponent do
  @moduledoc """
  Componente de Activos
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="m-16"> Actives </div>
    """
  end

end
