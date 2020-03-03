defmodule AccountingSystemWeb.ConfirmationComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML


  def mount(socket) do
    {:ok, assign(socket, show: true, message: nil) }
  end

  def render(assigns) do
    ~L"""
    <%= if @show do %>
    <div id="one" class="fixed w-full flex bottom-0 left-0 notification">
      <div class="top-12 py-16 ml-auto mr-auto " role="alert" >
        <div class="flex items-center bg-yellow-400 text-black font-bold rounded-t px-4 py-2">
          <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="exclamation-triangle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"
            class="flex-1 text-center h-6 w-6"><path fill="currentColor" d="M248.747 204.705l6.588 112c.373 6.343 5.626 11.295 11.979 11.295h41.37a12 12 0 0 0 11.979-11.295l6.588-112c.405-6.893-5.075-12.705-11.979-12.705h-54.547c-6.903 0-12.383 5.812-11.978 12.705zM330 384c0 23.196-18.804 42-42 42s-42-18.804-42-42 18.804-42 42-42 42 18.804 42 42zm-.423-360.015c-18.433-31.951-64.687-32.009-83.154 0L6.477 440.013C-11.945 471.946 11.118 512 48.054 512H527.94c36.865 0 60.035-39.993 41.577-71.987L329.577 23.985zM53.191 455.002L282.803 57.008c2.309-4.002 8.085-4.002 10.394 0l229.612 397.993c2.308 4-.579 8.998-5.197 8.998H58.388c-4.617.001-7.504-4.997-5.197-8.997z" class=""></path></svg>
        </div>
        <div class="border border-t-0 border-yellow-500 rounded-b bg-yellow-100 px-4 py-3 text-black">
          <b><p><%= @message %></p></b>
          <div class="inline-flex w-full mt-4 py-4">
            <button phx-click="si_" phx-target="#one" class="h-10 px-2 w-1/2 bg-teal-500 hover:bg-teal-400 text-white font-bold py-2 px-4 border border-teal-500 rounded">
              Sí
            </button>
            <button phx-click="no_" phx-target="#one" class="h-10 ml-5 px-2 w-1/2 bg-red-500 hover:bg-red-400 text-white font-bold py-2 px-4 border border-red-500 rounded">
              No
            </button>
          <div>
        </div>
      </div>
    </div>
    <% end %>
    """
  end

  def update(attrs, socket) do
    attrs |> IO.inspect(label: " --> --> Params confirmation -> ")
    {:ok, assign(socket, message: Map.get(attrs, :message), show: Map.get(attrs, :show))}
  end
end
