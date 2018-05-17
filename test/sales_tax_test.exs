defmodule SalesTaxTest do
  use ExUnit.Case

  test "greets the world" do
  assert SalesTax.compute() == %ShoppingCart{
  items: [
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
  ],
  sales_tax: 1.499,
  total: 29.829
}
  end
end
