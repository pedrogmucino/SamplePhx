defmodule AccountingSystemWeb.NotificationComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML


  def mount(socket) do
    {:ok, assign(socket, show: true, message: nil, notification_type: nil) }
  end

  def render(assigns) do
    ~L"""
    <%= if @show do %>
    <div id="x" class="z-10 fixed flex inset-0 zum">
    <div class="mt-64 mb-64 py-64 ml-auto mr-auto">
      <%= case @notification_type do %>
      <%= "notification" -> %>
        <div class="fixed z-40 w-full flex bottom-12 left-0 notification">
          <div class="z-40 w-120 top-12 py-6 px-12 ml-auto mr-auto bg-teal-100 border-t-4 border-teal-500 rounded-b text-teal-900  shadow-md role="alert">
            <div class="flex" items-center>
              <div class="py-1">
                <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="bomb" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="w-8 h-5 mr-1">
                  <path fill="currentColor" d="M256 8C119.033 8 8 119.033 8 256s111.033 248 248 248 248-111.033 248-248S392.967 8 256 8zm0 48c110.532 0 200 89.451 200 200 0 110.532-89.451 200-200 200-110.532 0-200-89.451-200-200 0-110.532 89.451-200 200-200m140.204 130.267l-22.536-22.718c-4.667-4.705-12.265-4.736-16.97-.068L215.346 303.697l-59.792-60.277c-4.667-4.705-12.265-4.736-16.97-.069l-22.719 22.536c-4.705 4.667-4.736 12.265-.068 16.971l90.781 91.516c4.667 4.705 12.265 4.736 16.97.068l172.589-171.204c4.704-4.668 4.734-12.266.067-16.971z">
                  </path>
                </svg>
              </div>
              <div>
                <p class="font-bold">Éxito</p>
                <p class="text-sm"><%= @message %></p>
              </div>
            </div>
          </div>
        </div>

        <%= "error" -> %>
        <div class="fixed z-40 w-full flex bottom-12 left-0 notification">
          <div class="z-40 w-120 top-12 py-6 px-12 ml-auto mr-auto bg-red-100 border-t-4 border-red-500 rounded-b text-red-900 shadow-md role="alert">
            <div class="flex" items-center>
              <div class="py-1">
                <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="bomb" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="w-8 h-5 mr-1">
                  <path fill="currentColor" d="M184 160c13.24 0 24-10.76 24-24s-10.76-24-24-24-24 10.76-24 24 10.76 24 24 24zm80 0c13.24 0 24-10.76 24-24s-10.76-24-24-24-24 10.76-24 24 10.76 24 24 24zm-128.15 68.54l-7.33 34.61c-2.67 12.62 5.42 24.85 16.45 24.85h158.08c11.03 0 19.12-12.23 16.45-24.85l-7.33-34.61C345.91 205.11 368 169.01 368 128 368 57.31 303.53 0 224 0S80 57.31 80 128c0 41.01 22.09 77.11 55.85 100.54zM224 48c52.94 0 96 35.89 96 80 0 23.3-12.84 45.57-35.21 61.1l-26.2 18.18 6.61 31.2.32 1.52h-83.03l.32-1.52 6.61-31.2-26.2-18.18C140.84 173.57 128 151.3 128 128c0-44.11 43.07-80 96-80zm214.7 418.95L284.31 400l154.39-66.95c8.03-3.71 11.53-13.21 7.82-21.24l-6.71-14.52c-3.71-8.02-13.21-11.52-21.23-7.82L224 373.85 29.42 289.48c-8.02-3.7-17.53-.2-21.23 7.82l-6.71 14.52c-3.71 8.02-.21 17.53 7.82 21.24L163.69 400 9.3 466.95c-8.03 3.7-11.53 13.21-7.82 21.24l6.71 14.52c3.71 8.02 13.21 11.52 21.23 7.82L224 426.15l194.58 84.37c8.02 3.7 17.53.2 21.23-7.82l6.71-14.52c3.71-8.02.21-17.53-7.82-21.23z">
                  </path>
                </svg>
              </div>
              <div>
                <p class="font-bold">Ha ocurrido un error</p>
                <p class="text-sm"><%= raw @message %></p>
              </div>
            </div>
          </div>
        </div>

        <%= nil -> %>

      <% end %>
      </div>
      </div>
    <% end %>
    """
  end

  def update(attrs, socket) do
    {:ok, assign(socket, message: Map.get(attrs, :message), show: Map.get(attrs, :show), notification_type: Map.get(attrs, :notification_type))}
  end

  def set_timer_notification() do
    Task.async(fn ->
      :timer.sleep(5500)
      %{message: "close_notification"}
    end)
    :ok
  end

  def set_timer_notification_error() do
    Task.async(fn ->
      :timer.sleep(5500)
      %{message: "close_error"}
    end)
  end

end
