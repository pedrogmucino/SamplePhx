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

        <div class="inline-block bg-blue-700 text-white px-6 py-4 w-full">
          <button class="ml-mar-380 -mr-2 -mt-4 text-white font-bold rounded shadow">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="h-5 w-5 ml-auto">
              <path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z" class=""></path>
            </svg>
          </button>
        </div>

      <div class="m-4 mr-4 mt-4 mb-0 border-t-2 border-gray-300"></div>
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
        <div class="ml-4 mr-4 border-solid border-2 border-gray-300 p-4 rounded">
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
