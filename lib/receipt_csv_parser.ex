defmodule ReceiptCsvParser do
  @moduledoc """
  This module is a CSV parser for a file that contains shopping cart info
  """

  @doc """
  This function is used to read line items from a file

  ## Examples
    iex> file_path = "input/shopping_basket1.csv"

    iex> ReceiptCsvParser.read_line_items(file_path)
    ["1, book, 12.49\n", "1, music cd, 14.99\n", "1, chocolate bar, 0.85"]
  """
  @spec read_line_items(String.t) :: list(String.t)
  def read_line_items(file_path) do
    File.stream!(file_path)
    |> Enum.to_list()
    |> tl
  end

  @doc """
  This function is used to parse the line items

  ## Examples
    iex> item_details = "1, book, 12.49\n"

    iex> ReceiptCsvParser.parse_item(item_details)
    %Item{
      basic_sales_tax_applicable: false,
      imported: false,
      name: "book",
      price: 12.49,
      quantity: 1
    }
  """
  @spec parse_item(String.t) :: Item.t()
  def parse_item(item) do
    [quantity, name, price] =
      item
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
    %{
      item
      | imported: Item.imported?(item),
        basic_sales_tax_applicable: Item.basic_sales_tax_applicable?(item)
    }
  end
end
