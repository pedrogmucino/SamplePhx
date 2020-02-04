defmodule AccountingSystemWeb.FormAccountView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.FormAccountLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.FormAccountView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

