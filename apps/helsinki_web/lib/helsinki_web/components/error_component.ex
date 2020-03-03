defmodule AccountingSystemWeb.ErrorComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML


  def mount(socket) do
    {:ok, assign(socket, show: true, error: nil) }
  end

  def render(assigns) do
    ~L"""
    <%= if @show do %>
    <div class="fixed z-40 w-full flex bottom-0 left-0 notification">
      <div class="z-40 top-12 py-16 ml-auto mr-auto " role="alert" >
      <div class="flex items-center bg-red-500 text-black font-bold rounded-t px-4 py-2">
      <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="siren-on" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"
      class="flex-1 text-center h-6 w-6"><path fill="currentColor" d="M512,320h-1.88L486.88,134.07A80.13,80.13,0,0,0,407.5,64h-175a80.13,80.13,0,0,0-79.38,70.08L129.88,320H128a32,32,0,0,0-32,32v64a32,32,0,0,0,32,32H512a32,32,0,0,0,32-32V352A32,32,0,0,0,512,320ZM184.88,138A48.07,48.07,0,0,1,232.5,96h175A48.07,48.07,0,0,1,455.12,138l22.76,182H231.82l24.11-180.83a8,8,0,0,0-6.87-9l-15.86-2.13a8,8,0,0,0-9,6.87L199.54,320H162.12ZM512,416H128V352H512ZM80,160H16a16,16,0,0,0,0,32H80a16,16,0,0,0,0-32Zm544,0H560a16,16,0,0,0,0,32h64a16,16,0,0,0,0-32ZM40.84,30.3l64,32a16,16,0,0,0,14.32-28.63l-64-32A16,16,0,0,0,40.84,30.3ZM528,64a16.17,16.17,0,0,0,7.16-1.69l64-32A16,16,0,0,0,584.84,1.67l-64,32A16,16,0,0,0,528,64Z" class=""></path></svg>
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
