defmodule ReceiptGeneratorTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "given cart details" do
    test "it prints out the cart details" do
      cart_details = %ShoppingCart{
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

      receipt_details = fn ->
        ReceiptGenerator.generate_details(cart_details)
      end

      assert capture_io(receipt_details) == "1, book, 12.49
1, music cd, 16.49
1, chocolate bar, 0.85

Sales Taxes: 1.5
Total: 29.83\n"
    end
  end
end
