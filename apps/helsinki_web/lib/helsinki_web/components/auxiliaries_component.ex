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
        <table class="table-auto">
          <thead>
            <tr>
              <th class="w-48 px-4 py-2">Tipo Póliza</th>
              <th class="w-40 px-4 py-2">Numero Póliza</th>
              <th class="w-48 px-4 py-2">Fecha</th>
              <th class="w-64 px-4 py-2">Cuenta Detalle</th>
              <th class="w-40 px-4 py-2">Caja</th>
              <th class="w-40 px-4 py-2">Abono</th>
              <th class="w-80 px-4 py-2">Concepto</th>
            </tr>
          </thead>
        </table>
        <div class="border-solid border-2 border-gray-300 p-4 rounded">
          <%= for item <- @list_auxiliaries do %>
            <div class="py-1">
              <label><b><%= item.nombre %></b></label>
              <div class="bg-gray-300 border rounded relative">
                <%= for item2 <- item.auxiliaries do %>
                  <div>
                    <div class="inline-flex w-48 px-2 py-2"><%= item2.tipo %></div>
                    <div class="inline-flex w-40 px-2 py-2"><%= item2.numero_poliza %></div>
                    <div class="inline-flex w-48 px-2 py-2"><%= item2.fecha %></div>
                    <div class="inline-flex w-64 px-2 py-2"><%= item2.cuenta_detalle %></div>
                    <div class="inline-flex w-40 px-2 py-2 justify-end"><%= item2.caja %></div>
                    <div class="inline-flex w-40 px-2 py-2 justify-end"><%= item2.abono %></div>
                    <div class="inline-flex w-80 px-2 py-2"><%= item2.concepto %></div>
                  </div>
                <% end %>
                <div>
                  <div class="inline-flex w-200 px-4 py-2">1</div>
                  <div class="inline-flex w-40 px-4 py-2 justify-end ml-5"><%= item.total_caja %></div>
                  <div class="inline-flex w-40 px-4 py-2 justify-end"><%= item.total_abono %></div>
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
