defmodule Item do
  defstruct quantity: 0, name: "", price: 0, imported: false, basic_sales_tax_applicable: true
  @imported_item_identifier "imported"
  @items_exempt_from_basic_sales_tax ["food", "book", "medical products", "chocolates", "chocolate"]

  def imported?(item) do
    String.contains?(item.name, @imported_item_identifier)
  end

  def basic_sales_tax_applicable?(item) do
    !String.contains?(item.name, @items_exempt_from_basic_sales_tax)
  end
end