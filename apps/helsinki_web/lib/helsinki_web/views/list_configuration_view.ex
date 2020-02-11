defmodule AccountingSystemWeb.ListConfigurationView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.ListConfigurationLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.ListConfigurationView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

