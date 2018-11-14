defmodule ReceiptGenerator do
  @moduledoc """
  This module is used to generate receipt details based on a purchase of some items
  """

  @doc """
  This function is used to print receipt details based on a purchase of some items

  ## Examples
      iex> cart_details = %ShoppingCart{
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

      iex> ReceiptGenerator.generate_details(cart_details)
      1, book, 12.49
      1, music cd, 16.49
      1, chocolate bar, 0.85

      Sales Taxes: 1.5
      Total: 29.83
      :ok
  """
  @spec generate_details(ShoppingCart.t()) :: :ok
  def generate_details(cart_details) do
    Enum.map(cart_details.items, fn item ->
      IO.puts("#{item.quantity}, #{item.name}, #{item.price}")
    end)

    IO.puts("\nSales Taxes: #{Float.round(cart_details.sales_tax, 2)}")
    IO.puts("Total: #{Float.round(cart_details.total, 2)}")
  end
end
