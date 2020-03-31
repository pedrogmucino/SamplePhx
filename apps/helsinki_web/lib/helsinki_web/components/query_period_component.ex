defmodule AccountingSystemWeb.QueryPeriodComponent do
  @moduledoc """
  Componente Query Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div class="m-16"> Query Period </div>
    """
  end

end
