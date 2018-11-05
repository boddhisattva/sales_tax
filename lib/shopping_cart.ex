defmodule ShoppingCart do
  @moduledoc """
  This module is used to maintain shopping cart information
  """

  defstruct total: 0, sales_tax: 0, items: []

  def new, do: %__MODULE__{}

  @doc """
  This function is used to initialize a cart product with item price based on quantity of purchase

  ## Examples
    iex> product = %Item{
           basic_sales_tax_applicable: true,
           imported: false,
           name: "music cd",
           price: 14.99,
           quantity: 2
         }

    iex> total_sales_tax_from_one_item = 1.5

    iex> ShoppingCart.initialize_cart_product(total_sales_tax_from_one_item, product)
         %Item{
           basic_sales_tax_applicable: true,
           imported: false,
           name: "music cd",
           price: 32.98,
           quantity: 2
         }
  """
  @spec initialize_cart_product(Float, Item) :: Item
  def initialize_cart_product(total_sales_tax_from_one_item, product) do
    %Item{
      price: Float.round(product.price + total_sales_tax_from_one_item, 2) * product.quantity,
      quantity: product.quantity,
      name: product.name,
      basic_sales_tax_applicable: product.basic_sales_tax_applicable,
      imported: product.imported
    }
  end

  @doc """
  This function is used to update cart details with a list of cart items,
  total cart cost and total sales tax with regard to the purchase

  ## Examples
    iex> shopping_cart = %ShoppingCart{items: [], sales_tax: 0, total: 0}

    iex>  cart_product = %Item{
            basic_sales_tax_applicable: true,
            imported: false,
            name: "music cd",
            price: 32.98,
            quantity: 2
          }

    iex> total_sales_tax_from_one_item = 1.5

    iex> ShoppingCart.update(shopping_cart, cart_product, total_sales_tax_from_one_item)
         %ShoppingCart{
           items: [
             %Item{
               basic_sales_tax_applicable: true,
               imported: false,
               name: "music cd",
               price: 32.98,
               quantity: 2
             }
           ],
           sales_tax: 3.0,
           total: 32.98
         }
  """
  @spec update(ShoppingCart, Item, Float) :: ShoppingCart
  def update(shopping_cart, cart_product, total_sales_tax_from_one_item) do
    %{
      shopping_cart
      | total: shopping_cart.total + Float.round(cart_product.price, 2),
        sales_tax: shopping_cart.sales_tax + total_sales_tax_from_one_item * cart_product.quantity,
        items: shopping_cart.items ++ [cart_product]
    }
  end
end
