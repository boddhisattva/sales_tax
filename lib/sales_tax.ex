defmodule SalesTax do
  @moduledoc """
  Documentation for SalesTax.
  """

  @doc """
  Compute Sales Tax.

  ## Examples

      iex> SalesTax.compute
          1, book, 12.49
          1, music cd, 16.49
          1, chocolate bar, 0.85

          Sales Taxes: 1.5
          Total: 29.83
          :ok
  """
  def compute do
    ReceiptCsvParser.read_line_items("input/shopping_basket1.csv")
    |> get_products()
    |> populate_shopping_cart_items()
    |> generate_receipt_details()
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

  defp generate_receipt_details(cart_details) do
    Enum.map cart_details.items, fn item ->
      IO.puts "#{item.quantity}, #{item.name}, #{item.price}"
    end
    IO.puts "\nSales Taxes: #{cart_details.sales_tax}"
    IO.puts "Total: #{cart_details.total}"
  end
end
