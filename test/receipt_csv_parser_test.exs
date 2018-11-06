defmodule ReceiptCsvParserTest do
  use ExUnit.Case

  describe "read_line_items" do
    test "it reads line items from the file" do
      filename = "input/shopping_basket1.csv"

      assert ReceiptCsvParser.read_line_items(filename) == [
               "1, book, 12.49\n",
               "1, music cd, 14.99\n",
               "1, chocolate bar, 0.85"
             ]
    end
  end

  describe "parse_item" do
    test "it parses item details and updates it with appropriate values" do
      item_details = "1, book, 12.49\n"

      assert ReceiptCsvParser.parse_item(item_details) == %Item{
               basic_sales_tax_applicable: false,
               imported: false,
               name: "book",
               price: 12.49,
               quantity: 1
             }
    end
  end
end
