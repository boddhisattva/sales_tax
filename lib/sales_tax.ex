defmodule SalesTax do
  @moduledoc """
  Documentation for SalesTax.
  """

  @doc """
  Compute Sales Tax.

  ## Examples

      iex> SalesTax.compute
%ShoppingCart{
  items: [
    %Item{
      basic_sales_tax_applicable: false,
      imported: false,
      name: "book",
      price: 12.49,
      quantity: 1
    },
    %Item{
      basic_sales_tax_applicable: true,
      imported: false,
      name: "music cd",
      price: 16.49,
      quantity: 1
    },
    %Item{
      basic_sales_tax_applicable: false,
      imported: false,
      name: "chocolate bar",
      price: 0.85,
      quantity: 1
    }
  ],
  sales_tax: 1.5,
  total: 29.83
}

  """
  def compute do
    ReceiptCsvParser.read_line_items("input/shopping_basket1.csv")
    |> get_products()
    |> populate_shopping_cart_items()
  end

  defp get_products(items) do
    Enum.map items, fn item ->
      ReceiptCsvParser.parse_item(item)
    end
  end

  defp populate_shopping_cart_items(products) do
    List.foldl(products, ShoppingCart.new, fn product, shopping_cart ->
      total_sales_tax_from_one_item = SalesTaxCalculator.calculate_total_sales_tax(product)
      cart_product = ShoppingCart.initialize_cart_product(total_sales_tax_from_one_item, product)
      ShoppingCart.update(shopping_cart, cart_product, total_sales_tax_from_one_item)
    end)
  end
end
