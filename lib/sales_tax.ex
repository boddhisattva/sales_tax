defmodule SalesTax do
  @moduledoc """
  Documentation for SalesTax.
  """

  @doc """
  Compute Sales Tax.

  ## Examples

      iex> SalesTax.compute
[
  %Item{
    basic_sales_tax_applicable: false,
    imported: false,
    name: "book",
    price: 12.49,
    quantity: "1"
  },
  %Item{
    basic_sales_tax_applicable: true,
    imported: false,
    name: "music cd",
    price: 16.489,
    quantity: "1"
  },
  %Item{
    basic_sales_tax_applicable: false,
    imported: false,
    name: "chocolate bar",
    price: 0.85,
    quantity: "1"
  }
]

  """
  def compute do
    rows =
      File.stream!("input/shopping_basket1.csv")
      |> Enum.to_list

    [head | items] = rows

    products = Enum.map items, fn item ->
                 product = item |> String.split(",")
                 product = %Item{quantity: String.trim(Enum.at(product, 0)), name: String.trim(Enum.at(product, 1)), price: String.to_float(String.trim(Enum.at(product, 2)))}
                 product = imported?(product)
                 basic_sales_tax_applicable?(product)
               end

    items_with_tax = Enum.map products, fn product ->
                       SalesTaxCalculator.calculate_tax(product)
                     end
  end

  defp imported?(item) do
    %{ item | imported: String.contains?(item.name, "imported")}
  end

  defp basic_sales_tax_applicable?(item) do
    %{ item | basic_sales_tax_applicable: !String.contains?(item.name, ["food", "book", "medical products", "chocolates", "chocolate"])}
  end


end
