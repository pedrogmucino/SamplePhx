defmodule AccountingSystemWeb.AccountView do
  use AccountingSystemWeb, :view
end
defmodule AccountingSystemWeb.AccountLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.AccountView, "index_fake.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end
