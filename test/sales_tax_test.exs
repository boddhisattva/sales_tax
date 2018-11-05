defmodule SalesTaxTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "main" do
    test "it computes sales tax and displays the related details" do
      args = ["--filename=input/shopping_basket1.csv"]

      compute_sales_tax = fn ->
        SalesTax.main(args)
      end

      assert capture_io(compute_sales_tax) =~ "1, book, 12.49
1, music cd, 16.49
1, chocolate bar, 0.85

Sales Taxes: 1.5
Total: 29.83"
    end

    test "it returns the appropriate response if file name specified does not exist" do
      args = ["--filename=input/random_file_name.csv"]

      compute_sales_tax = fn ->
        SalesTax.main(args)
      end

      assert capture_io(compute_sales_tax) =~ "Specified file name does not exist. Please try again."
    end

    test "filename option not specified prompts a user with message to specify filename " do
      args = ["input/random_file_name.csv"]

      compute_sales_tax = fn ->
        SalesTax.main(args)
      end

      assert capture_io(compute_sales_tax) =~ "Please specify the input receipt file name when trying to compute Sales Tax"
    end
  end
end
