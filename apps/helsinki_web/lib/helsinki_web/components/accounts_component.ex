defmodule AccountingSystemWeb.AccountsComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <div class="bg-white h-hoch-90 w-64 mt-16 ml-16 block">
        <div class="inline-flex w-full py-3 bg-blue-800">
          <div class="relative w-full px-2">
            <input class="h-8 w-full rounded border" placeholder="Buscar Cuenta" >
            <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
              class="absolute right-0 top-0 h-5 w-5 mr-4 mt-1">
              <g>
                <path fill="currentColor" d="M208 80a128 128 0 1 1-90.51 37.49A127.15 127.15 0 0 1 208 80m0-80C93.12 0 0 93.12 0 208s93.12 208 208 208 208-93.12 208-208S322.88 0 208 0z"
                class="text-blue-800">
                </path>
                <path fill="currentColor" d="M504.9 476.7L476.6 505a23.9 23.9 0 0 1-33.9 0L343 405.3a24 24 0 0 1-7-17V372l36-36h16.3a24 24 0 0 1 17 7l99.7 99.7a24.11 24.11 0 0 1-.1 34z"
                class="text-blue-700">
                </path>
              </g>
            </svg>
          </div>
        </div>

        <div class="w-full items-center inline-flex mt-3">
            <button class="ml-3 py-2 px-3 bg-blue-100 items-center inline-flex rounded">
              <label class="cursor-pointer text-blue-900 mr-2 font-bold">Nueva Cuenta</label>
              <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="home" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
              class="h-6 w-6 ml-2">
                <g>
                  <path fill="currentColor" d="M176 448a32 32 0 0 0 32 32h32a32 32 0 0 0 32-32V304h-96zm64-416h-32a32 32 0 0 0-32 32v144h96V64a32 32 0 0 0-32-32z"
                    class="text-blue-500">
                    </path>
                  <path fill="currentColor" d="M448 240v32a32 32 0 0 1-32 32H32a32 32 0 0 1-32-32v-32a32 32 0 0 1 32-32h384a32 32 0 0 1 32 32z"
                    class="text-blue-900">
                  </path>
                </g>
              </svg>

            </button>
          </div>
      </div>
    """
  end
  def mount(socket) do
    {:ok, socket}
  end

  def update(_attrs, socket) do
      {:ok, socket}
  end

end
