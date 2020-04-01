defmodule AccountingSystemWeb.PeriodView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.PeriodLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.PeriodView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

