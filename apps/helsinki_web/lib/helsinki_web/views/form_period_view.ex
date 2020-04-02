
defmodule AccountingSystemWeb.FormPeriodView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.FormPeriodLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.FormPeriodView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

