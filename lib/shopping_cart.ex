defmodule ShoppingCart do
  defstruct total: 0, sales_tax: 0, items: []

  def new, do: %__MODULE__{}

  def initialize_cart_product(total_sales_tax_from_one_item, product) do
    %Item{
      price: Float.round(product.price + total_sales_tax_from_one_item, 2) * product.quantity,
      quantity: product.quantity,
      name: product.name,
      basic_sales_tax_applicable: product.basic_sales_tax_applicable,
      imported: product.imported
    }
  end

  def update(shopping_cart, cart_product, total_sales_tax_from_one_item) do
    %{
      shopping_cart
      | total: shopping_cart.total + Float.round(cart_product.price, 2),
        sales_tax: shopping_cart.sales_tax + total_sales_tax_from_one_item * cart_product.quantity,
        items: shopping_cart.items ++ [cart_product]
    }
  end
end
