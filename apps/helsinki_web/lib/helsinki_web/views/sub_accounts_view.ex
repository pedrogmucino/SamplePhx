defmodule AccountingSystemWeb.SubAccountsView do
  use AccountingSystemWeb, :view
end
defmodule AccountingSystemWeb.SubAccountsLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.SubAccountsView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end
