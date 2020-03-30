defmodule AccountingSystemWeb.FiscalsComponent do
  @moduledoc """
  Componente de Fiscales
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div class="m-16"> Fiscals </div>
    """
  end

end
