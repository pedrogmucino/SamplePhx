defmodule AccountingSystem.XlsxFunctions do

  alias Elixlsx.Workbook
  alias Elixlsx.Sheet

  def get_data(path, name) do
    File.write(name, path)
    {:ok, file} = Xlsxir.multi_extract(name, 0)
    data = Xlsxir.get_list(file)
    File.close(file)
    File.rm(name)
    data
  end

  def create_template(name) do
    sheet1 = %Sheet{
      name: "Template",
      rows: [format_list(get_header())]
    }
    |> Sheet.set_col_width("A", 50)
    |> Sheet.set_col_width("B", 100)
    |> Sheet.set_col_width("C", 20)
    |> Sheet.set_col_width("D", 16)
    |> Sheet.set_col_width("E", 16)

    Workbook.append_sheet(%Workbook{}, sheet1)
      |> Elixlsx.write_to(name)
  end

  def get_header() do
    ["Cuenta", "Concepto", "Departamento", "Debe", "Haber"]
  end

  def format_list(list) do
    Enum.map(list, fn row -> [row, bold: true, align_vertical: :center, align_horizontal: :center, size: 16] end)
  end
end
