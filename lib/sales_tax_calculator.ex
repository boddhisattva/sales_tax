defmodule SalesTaxCalculator do

  @basic_sales_tax_rate 0.1
  @import_duty_sales_tax_rate 0.05

  def calculate_basic_sales_tax(product) do
    if product.basic_sales_tax_applicable do
      product.price * @basic_sales_tax_rate
    else
      0
    end
  end

  def calculate_import_duty_sales_tax(product) do
    if product.imported do
      product.price * @import_duty_sales_tax_rate
    else
      0
    end
  end
end