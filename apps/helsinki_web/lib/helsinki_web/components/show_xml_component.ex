defmodule AccountingSystemWeb.ShowXmlComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.GenericFunctions, as: Generic

  def mount(socket) do
    {:ok, assign(socket, xml_data: Generic.to_string_empty)}
  end

  def update(params, socket) do
    xml_data = AccountingSystem.AuxiliaryHandler.get_xml_file_to_alexandria(params.xml_id)
    {:ok, assign(socket, xml_data: xml_data)}
  end

  def render(assigns) do
    ~L"""
      <div class="m-16"> <%= @xml_data %>  </div>
    """
  end

end
