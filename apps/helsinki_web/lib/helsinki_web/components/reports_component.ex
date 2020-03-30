defmodule AccountingSystemWeb.ReportsComponent do
  @moduledoc """
  Componente de Reportes
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div class="m-16"> Reports </div>
    """
  end

end
