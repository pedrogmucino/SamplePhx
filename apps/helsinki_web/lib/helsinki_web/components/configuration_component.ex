defmodule AccountingSystemWeb.ConfigurationComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="bg-white mt-16 ml-1 w-80 h-hoch-93 rounded border">

      <div class="inline-block bg-blue-700 text-white px-6 py-4 w-full">
        <h1 class="text-2xl font-medium text-white block">Account Configuration</h1>
        <div class="mt-2">
          <label class="block">Level: <b>2</b></label>
          <label class="block">Max Current Size: <b>0</b></label>
        </div>
      </div>

      <div class="h-hoch-80 px-8 w-full py-6 inline-flex -mt-8 relative" >
        <form class="w-full py-6 my-2">
          <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Size</label>
          <input class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Size">
        </form>

        <div class="inline-flex w-full py-3 absolute bottom-0 right-0 pr-8">
          <button class="ml-auto w-32 py-2 bg-teal-500 text-teal-100 items-center inline-flex font-bold rounded shadow hover:bg-teal-400 focus:shadow-outline focus:outline-none rounded" type="button">
            <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="save" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
              class="h-4 w-4 mr-2 ml-auto">
              <g class="fa-group">
                <path fill="currentColor" d="M288 352a64 64 0 1 1-64-64 64 64 0 0 1 64 64z"
                class="text-white">
                </path>
                <path fill="currentColor" d="M433.94 129.94l-83.88-83.88A48 48 0 0 0 316.12 32H48A48 48 0 0 0 0 80v352a48 48 0 0 0 48 48h352a48 48 0 0 0 48-48V163.88a48 48 0 0 0-14.06-33.94zM224 416a64 64 0 1 1 64-64 64 64 0 0 1-64 64zm96-204a12 12 0 0 1-12 12H76a12 12 0 0 1-12-12V108a12 12 0 0 1 12-12h228.52a12 12 0 0 1 8.48 3.52l3.48 3.48a12 12 0 0 1 3.52 8.48z"
                class="text-white">
                </path>
              </g>
            </svg>
            <label class="cursor-pointer mr-auto text-white">Save</label>
          </button>
        </div>
      </div>




    </div>
    """

  end

end
