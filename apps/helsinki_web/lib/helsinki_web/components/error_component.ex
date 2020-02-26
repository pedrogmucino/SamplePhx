defmodule AccountingSystemWeb.ErrorComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML


  def mount(socket) do
    {:ok, assign(socket, show: true, error: nil) }
  end

  def render(assigns) do
    ~L"""
    <%= if @show do %>
    <div class="fixed w-full flex bottom-0 left-0 notification">
      <div class="top-12 py-16 ml-auto mr-auto " role="alert" >
        <div class="bg-red-500 text-white font-bold rounded-t px-4 py-2">
          Error
        </div>
        <div class="border border-t-0 border-red-400 rounded-b bg-red-100 px-4 py-3 text-red-700">
          <p><%= @error %></p>
        </div>
      </div>
    </div>
    <% end %>
    """
  end

  def update(attrs, socket) do
    {:ok, assign(socket, error: Map.get(attrs, :error), show: Map.get(attrs, :show))}
  end
end
