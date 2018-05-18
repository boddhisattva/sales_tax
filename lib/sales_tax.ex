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
      File.stream!("input/shopping_basket1.csv")
      |> Enum.to_list
      |> tl
      |> get_products()
      |> populate_shopping_cart_items()
  end

  defp get_products(items) do
    Enum.map items, fn item ->
       parse_item(item)
       |> imported?()
       |> basic_sales_tax_applicable?()
    end
  end

  defp populate_shopping_cart_items(products) do
    List.foldl(products, ShoppingCart.new, fn product, shopping_cart ->
      total_sales_tax_from_one_item = SalesTaxCalculator.calculate_total_sales_tax(product)
      cart_product = initialize_cart_product(product, total_sales_tax_from_one_item)
      update_shopping_cart(shopping_cart, cart_product, total_sales_tax_from_one_item)
    end)
  end

  defp parse_item(item) do
    product = item |> String.split(",")
    %Item{quantity: parse_quantity(product), name: parse_name(product), price: parse_price(product)}
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

  defp initialize_cart_product(product, total_sales_tax_from_one_item) do
    %Item{price: (Float.round(product.price + total_sales_tax_from_one_item, 2)) * product.quantity, quantity: product.quantity,
          name: product.name, basic_sales_tax_applicable: product.basic_sales_tax_applicable,
          imported: product.imported}
  end

  defp update_shopping_cart(shopping_cart, cart_product, total_sales_tax_from_one_item) do
    %{ shopping_cart
       | total: shopping_cart.total + Float.round(cart_product.price, 2),
         sales_tax: shopping_cart.sales_tax + total_sales_tax_from_one_item * cart_product.quantity,
         items: shopping_cart.items ++ [cart_product] }
  end

  defp imported?(item) do
    %{ item | imported: String.contains?(item.name, "imported")}
  end

  defp basic_sales_tax_applicable?(item) do
    %{ item | basic_sales_tax_applicable: !String.contains?(item.name, ["food", "book", "medical products", "chocolates", "chocolate"])}
  end
end
