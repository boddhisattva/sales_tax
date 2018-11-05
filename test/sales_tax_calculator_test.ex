defmodule SalesTaxCalculatorTest do
  use ExUnit.Case

  describe "given a product" do
    test "calculates the total sales tax with regard to the product" do
      product = %Item{
        basic_sales_tax_applicable: true,
        imported: true,
        name: "imported bottle of perfume",
        price: 27.99,
        quantity: 1
      }

      assert SalesTaxCalculator.calculate_total_sales_tax(product) == 4.2
    end
  end
end