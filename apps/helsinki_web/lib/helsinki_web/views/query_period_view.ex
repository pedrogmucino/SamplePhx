defmodule AccountingSystemWeb.QueryPeriodView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.QueryPeriodLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.QueryPeriodView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

