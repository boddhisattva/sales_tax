defmodule SalesTaxCalculator do

  @basic_sales_tax_rate 1.1

  def calculate_tax(product) do
    if product.basic_sales_tax_applicable do
      %{ product | price: product.price * @basic_sales_tax_rate }
    else
      product
    end
  end
end