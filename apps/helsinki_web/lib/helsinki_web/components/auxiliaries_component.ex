defmodule AccountingSystemWeb.AuxiliariesComponent do
  @moduledoc """
  Componente Form Auxiliaries Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, assign(socket, list_auxiliaries: [])}
  end

  def update(attrs, socket) do
    {:ok, assign(socket, list_auxiliaries: attrs.list_auxiliaries)}
  end

  def render(assigns) do
    ~L"""
      <div id="auxiliaries_list" class="mt-56 w-full bg-white h-hoch-76 overflow-y-scroll">
        <div class="ml-4 mr-4 mb-4 border-solid border-2 border-gray-300 p-4 rounded">
          <%= for item <- @list_auxiliaries do %>
            <div class="py-1">
              <label><b><%= item.name %></b></label>
              <div class="bg-gray-300 border rounded relative">
                <%= for item2 <- item.details do %>
                  <div>
                    <div class="inline-flex w-48 px-2 py-2"><%= item2.policy_type %></div>
                    <div class="inline-flex w-32 px-2 py-2"><%= item2.number %></div>
                    <div class="inline-flex w-32 px-2 py-2"><%= item2.date %></div>
                    <div class="inline-flex w-80 px-2 py-2"><%= item.code %></div>
                    <div class="inline-flex w-40 px-2 py-2 justify-end" phx-hook="format_number"><%= if item2.auxiliary_type == "D", do: item2.amount %></div>
                    <div class="inline-flex w-40 px-2 py-2 justify-end" phx-hook="format_number"><%= if item2.auxiliary_type == "H", do: item2.amount %></div>
                    <div class="inline-flex w-82 px-2 py-2"><%= item2.concept %></div>
                  </div>
                <% end %>
                <div>
                  <div class="inline-flex w-200 py-4"></div>
                  <div class="inline-flex w-40 py-2 px-12 justify-end ml-5 font-semibold" phx-hook="format_number"><%= item.debe %></div>
                  <div class="inline-flex w-40 px-12 justify-end font-semibold" phx-hook="format_number"><%= item.haber %></div>
                </div>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    """
  end

end
