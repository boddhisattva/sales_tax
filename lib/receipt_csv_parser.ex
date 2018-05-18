defmodule ReceiptCsvParser do
  def read_line_items(file_path) do
    File.stream!(file_path)
    |> Enum.to_list
    |> tl
  end

  def parse_item(item) do
    product = item |> String.split(",")
    %Item{quantity: parse_quantity(product), name: parse_name(product), price: parse_price(product)}
    |> update_other_item_details()
  end

  defp parse_quantity(product) do
    Enum.at(product, 0)
    |> String.trim()
    |> String.to_integer()
  end

  defp parse_name(product) do
    String.trim(Enum.at(product, 1))
  end

  defp parse_price(product) do
    Enum.at(product, 2)
    |> String.trim()
    |> String.to_float()
  end

  defp update_other_item_details(item) do
    %{item | imported: Item.imported?(item),
             basic_sales_tax_applicable: Item.basic_sales_tax_applicable?(item)}
  end
end