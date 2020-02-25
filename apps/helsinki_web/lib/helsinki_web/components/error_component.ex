defmodule AccountingSystemWeb.ErrorComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML


  def mount(socket) do
    {:ok, socket }
  end

  def render(assigns) do
    ~L"""
    <div class="top-12 py-16" role="alert" >
      <div class="bg-red-500 text-white font-bold rounded-t px-4 py-2">
        Error
      </div>
      <div class="border border-t-0 border-red-400 rounded-b bg-red-100 px-4 py-3 text-red-700">
        <p><%= @error %></p>
      </div>
    </div>
    """
  end
end
