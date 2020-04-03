defmodule AccountingSystemWeb.AuxiliariesComponent do
  @moduledoc """
  Componente Form Auxiliaries Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, assign(socket, list_auxiliaries: get_auxiliaries())}
  end

  def update(_attrs, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div class="mt-16 ml-16 h-hoch-93 w-full bg-white">
        <table class="table-auto w-full">
          <thead>
            <tr>
              <th class="w-1/10 px-4 py-2">Tipo Póliza</th>
              <th class="w-1/10 px-4 py-2">Numero Póliza</th>
              <th class="w-1/10 px-4 py-2">Fecha</th>
              <th class="w-2/10 px-4 py-2">Cuenta Detalle</th>
              <th class="w-1/10 px-4 py-2">Caja</th>
              <th class="w-1/10 px-4 py-2">Abono</th>
              <th class="w-3/10 px-4 py-2">Concepto</th>
            </tr>
          </thead>
        </table>
        <div class="border-solid border-2 border-gray-300 p-4 rounded">
          <%= for item <- @list_auxiliaries do %>
            <div class="py-1">
              <label> <%= item.nombre %> </label>
              <div class="bg-gray-300 border rounded relative">
                <%= for item2 <- item.auxiliaries do %>
                  <div>
                    <label><%= item2.tipo %></label>
                    <label><%= item2.numero_poliza %></label>
                    <label><%= item2.fecha %></label>
                    <label><%= item2.cuenta_detalle %></label>
                    <label><%= item2.caja %></label>
                    <label><%= item2.abono %></label>
                    <label><%= item2.concepto %></label>
                  </div>
                <% end %>
                <div>
                  <label><%= item.total_caja %></label>
                  <label><%= item.total_abono %></label>
                </div>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    """
  end

  defp get_auxiliaries(), do:
  [
    %{
      nombre: "Acredor 1",
      total_caja: "50.00",
      total_abono: "50.00",
      auxiliaries: [
        %{
          tipo: "Gastos",
          numero_poliza: "1",
          fecha: "01/28/2020",
          cuenta_detalle: "2-001-002-001",
          caja: "",
          abono: "50.00",
          concepto: "Sueldos y salarios por pagar"
        },
        %{
          tipo: "Egresos",
          numero_poliza: "1",
          fecha: "01/28/2020",
          cuenta_detalle: "2-001-002-001",
          caja: "50.00",
          abono: "",
          concepto: "Pago de sueldos y salarios"
        }
      ]
    },
    %{
      nombre: "Bancomer",
      total_caja: "50.00",
      total_abono: "50.00",
      auxiliaries: [
        %{
          tipo: "Egresos",
          numero_poliza: "1",
          fecha: "01/28/2020",
          cuenta_detalle: "1-001-002-001",
          caja: "",
          abono: "50.00",
          concepto: "Sueldos y salarios por pagar"
        },
        %{
          tipo: "Ingresos",
          numero_poliza: "1",
          fecha: "01/28/2020",
          cuenta_detalle: "1-001-002-002",
          caja: "50.00",
          abono: "",
          concepto: "Cobranza Cliente"
        }
      ]
    }
  ]

end
