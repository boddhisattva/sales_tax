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
                 %Item{quantity: String.to_integer(String.trim(Enum.at(product, 0))), name: String.trim(Enum.at(product, 1)), price: String.to_float(String.trim(Enum.at(product, 2)))}
                 |> imported?()
                 |> basic_sales_tax_applicable?()
               end

    overall_total_sales_tax = 0

    items_with_tax =  List.foldl(products, ShoppingCart.new, fn product, shopping_cart ->
                      basic_sales_tax_from_one_item = SalesTaxCalculator.calculate_basic_sales_tax(product)
                      import_duty_sales_tax_from_one_item = SalesTaxCalculator.calculate_import_duty_sales_tax(product)
                      total_sales_tax_from_one_item = basic_sales_tax_from_one_item + import_duty_sales_tax_from_one_item
                      cart_product = %Item{price: (Float.round(product.price + total_sales_tax_from_one_item, 2)) * product.quantity, quantity: product.quantity,
                                           name: product.name, basic_sales_tax_applicable: product.basic_sales_tax_applicable,
                                           imported: product.imported}
                      %{ shopping_cart
                         | total: shopping_cart.total + Float.round(cart_product.price, 2),
                           sales_tax: shopping_cart.sales_tax + total_sales_tax_from_one_item * product.quantity,
                           items: shopping_cart.items ++ [cart_product] }
                    end)
  end

  defp imported?(item) do
    %{ item | imported: String.contains?(item.name, "imported")}
  end

  defp basic_sales_tax_applicable?(item) do
    %{ item | basic_sales_tax_applicable: !String.contains?(item.name, ["food", "book", "medical products", "chocolates", "chocolate"])}
  end


end
