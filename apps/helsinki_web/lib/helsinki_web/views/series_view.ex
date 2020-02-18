defmodule AccountingSystemWeb.SeriesView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.SeriesLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.SeriesView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end
