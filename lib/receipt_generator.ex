defmodule ReceiptGenerator do
  def generate_details(cart_details) do
    Enum.map(cart_details.items, fn item ->
      IO.puts("#{item.quantity}, #{item.name}, #{item.price}")
    end)

    IO.puts("\nSales Taxes: #{Float.round(cart_details.sales_tax, 2)}")
    IO.puts("Total: #{Float.round(cart_details.total, 2)}")
  end
end
