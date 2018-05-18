defmodule ReceiptCsvParser do
  def read_line_items(file_path) do
    File.stream!(file_path)
    |> Enum.to_list
    |> tl
  end

  def parse_item(item) do
    [quantity, name, price] = item
                              |> String.split(",")
                              |> Enum.map(fn x -> String.trim(x) end)
    %Item{quantity: parse_quantity(quantity), name: name, price: parse_price(price)}
    |> update_other_item_details()
  end

  defp parse_quantity(quantity) do
    String.to_integer(quantity)
  end

  defp parse_price(price) do
    String.to_float(price)
  end

  defp update_other_item_details(item) do
    %{item | imported: Item.imported?(item),
             basic_sales_tax_applicable: Item.basic_sales_tax_applicable?(item)}
  end
end