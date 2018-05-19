defmodule SalesTaxTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "greets the world" do
    filename = "input/shopping_basket1.csv"

    compute_sales_tax = fn ->
      SalesTax.compute(filename)
    end

  assert capture_io(compute_sales_tax) =~ "1, book, 12.49
1, music cd, 16.49
1, chocolate bar, 0.85

Sales Taxes: 1.5
Total: 29.83"
  end
end
