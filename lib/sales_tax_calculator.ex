defmodule SalesTaxCalculator do

  @basic_sales_tax_rate 0.1
  @import_duty_sales_tax_rate 0.05
  @number_to_round_off_to 0.05

  def calculate_basic_sales_tax(product) do
    if product.basic_sales_tax_applicable do
      round_up_to_the_nearest_number(product.price * @basic_sales_tax_rate)
    else
      0
    end
  end

  def calculate_import_duty_sales_tax(product) do
    if product.imported do
      round_up_to_the_nearest_number(product.price * @import_duty_sales_tax_rate)
    else
      0
    end
  end

  defp round_up_to_the_nearest_number(price) do
    Float.round(Float.ceil(price / @number_to_round_off_to) * @number_to_round_off_to, 2)
  end
end