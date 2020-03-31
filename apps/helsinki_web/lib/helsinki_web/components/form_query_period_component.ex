defmodule AccountingSystemWeb.FormQueryPeriodComponent do
  @moduledoc """
  Componente Form Query Period Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def update(_attrs, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div class="m-16"> Form query </div>
    """
  end

end
