defmodule SalesTaxCalculator do
  @moduledoc """
  This module is used to calculate sales tax for an item
  """

  @basic_sales_tax_rate 0.1
  @import_duty_sales_tax_rate 0.05
  @number_to_round_off_to 0.05

  @doc """
  This function is used to calculate total sales tax with regard to an item

  ## Examples
    iex> product = %Item{
            basic_sales_tax_applicable: true,
            imported: true,
            name: "imported bottle of perfume",
            price: 27.99,
            quantity: 1
          }

    iex> SalesTaxCalculator.calculate_total_sales_tax(product)
    4.2
  """
  @spec calculate_total_sales_tax(Item) :: float
  def calculate_total_sales_tax(product) do
    total_amount =
      calculate_basic_sales_tax(product.basic_sales_tax_applicable, product.price) +
        calculate_import_duty_sales_tax(product)

    if total_amount != 0 do
      Float.round(total_amount, 2)
    else
      total_amount
    end
  end

  defp calculate_basic_sales_tax(true, product_price) do
    round_up_to_the_nearest_number(product_price * @basic_sales_tax_rate)
  end

  defp calculate_basic_sales_tax(false, _product_price) do
    0
  end

  defp calculate_import_duty_sales_tax(product) do
    if product.imported do
      round_up_to_the_nearest_number(product.price * @import_duty_sales_tax_rate)
    else
      0
    end
  end

  defp round_up_to_the_nearest_number(price) do
    (price / @number_to_round_off_to)
    |> Float.ceil()
    |> Kernel.*(@number_to_round_off_to)
    |> Float.round(2)
  end
end
