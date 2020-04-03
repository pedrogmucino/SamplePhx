defmodule AccountingSystemWeb.AuxiliariesView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.AuxiliariesLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.AuxiliariesView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

