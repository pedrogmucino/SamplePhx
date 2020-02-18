defmodule AccountingSystemWeb.ConfigurationView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.ConfigurationLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.ConfigurationView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

