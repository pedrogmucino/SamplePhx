
defmodule AccountingSystemWeb.FormAuxiliariesView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.FormAuxiliariesLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.FormAuxiliariesView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

