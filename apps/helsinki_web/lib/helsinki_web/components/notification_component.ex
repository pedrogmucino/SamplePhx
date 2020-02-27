defmodule AccountingSystemWeb.NotificationComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML


  def mount(socket) do
    {:ok, assign(socket, show: true, message: nil) }
  end

  def render(assigns) do
    ~L"""
    <%= if @show do %>
    <div class="fixed w-full flex bottom-0 left-0 notification">
      <div class="top-12 py-16 ml-auto mr-auto " role="alert" >
        <div class="bg-teal-500 text-white font-bold rounded-t px-4 py-2">
          Información
        </div>
        <div class="border border-t-0 border-teal-400 rounded-b bg-teal-100 px-4 py-3 text-teal-700">
          <p><%= @message %></p>
        </div>
      </div>
    </div>
    <% end %>
    """
  end

  def update(attrs, socket) do
    {:ok, assign(socket, message: Map.get(attrs, :message), show: Map.get(attrs, :show))}
  end
end
