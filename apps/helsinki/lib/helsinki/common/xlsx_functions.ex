defmodule AccountingSystem.XlsxFunctions do
  def get_data(path, name) do
    File.write(name, path)
    {:ok, file} = Xlsxir.multi_extract(name, 0)
    data = Xlsxir.get_list(file)
    File.close(file)
    File.rm(name)
    data
  end
end
