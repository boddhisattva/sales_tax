defmodule ReceiptGenerator do
  def generate_details(cart_details) do
    Enum.map cart_details.items, fn item ->
      IO.puts "#{item.quantity}, #{item.name}, #{item.price}"
    end
    IO.puts "\nSales Taxes: #{cart_details.sales_tax}"
    IO.puts "Total: #{cart_details.total}"
  end
end
