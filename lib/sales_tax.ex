defmodule SalesTax do
  @moduledoc """
  Documentation for SalesTax.
  """

  @doc """
  Compute Sales Tax.

  ## Examples

      iex> SalesTax.main(["--filename=input/shopping_basket1.csv"])
          1, book, 12.49
          1, music cd, 16.49
          1, chocolate bar, 0.85

          Sales Taxes: 1.5
          Total: 29.83
          :ok
  """
  def main(args) do
    {opts, _, _} =
      OptionParser.parse(args, switches: [filename: :string], aliases: [f: :filename])

    if opts[:filename] do
      process(File.exists?(opts[:filename]), opts[:filename])
    else
      IO.puts("Please specify the input receipt file name when trying to compute Sales Tax")
    end
  end

  defp process(true, filename) do
    compute(filename)
  end

  defp process(false, _filename) do
    IO.puts("Specified file name does not exist. Please try again.")
  end

  defp compute(filename) do
    ReceiptCsvParser.read_line_items(filename)
    |> get_products()
    |> populate_shopping_cart_items()
    |> ReceiptGenerator.generate_details()
  end

  defp get_products(items) do
    Enum.map(items, fn item ->
      ReceiptCsvParser.parse_item(item)
    end)
  end

  defp populate_shopping_cart_items(products) do
    List.foldl(products, ShoppingCart.new(), fn product, shopping_cart ->
      total_sales_tax_from_one_item = SalesTaxCalculator.calculate_total_sales_tax(product)
      cart_product = ShoppingCart.initialize_cart_product(total_sales_tax_from_one_item, product)
      ShoppingCart.update(shopping_cart, cart_product, total_sales_tax_from_one_item)
    end)
  end
end
