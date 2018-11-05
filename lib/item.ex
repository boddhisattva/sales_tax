defmodule Item do
  @moduledoc """
  This module contains Item specific information
  """

  defstruct quantity: 0, name: "", price: 0, imported: false, basic_sales_tax_applicable: true
  @imported_item_identifier "imported"
  @items_exempt_from_basic_sales_tax [
    "food",
    "book",
    "medical products",
    "chocolates",
    "chocolate",
    "pills"
  ]

  @doc """
  This function is used to check whether or not a given item is imported

  ## Examples
    iex> item = %Item{
            basic_sales_tax_applicable: true,
            imported: false,
            name: "book",
            price: 12.49,
            quantity: 1
          }
    iex> Item.imported?(item)
    false
  """
  @spec imported?(Item) :: boolean
  def imported?(item) do
    String.contains?(item.name, @imported_item_identifier)
  end

  @doc """
  This function is used to check whether or not basic sales tax is applicable with regard to an item

  ## Examples
    iex> item = %Item{
            basic_sales_tax_applicable: true,
            imported: false,
            name: "book",
            price: 12.49,
            quantity: 1
          }
    iex> Item.basic_sales_tax_applicable?(item)
    true
  """
  @spec basic_sales_tax_applicable?(Item) :: boolean
  def basic_sales_tax_applicable?(item) do
    !String.contains?(item.name, @items_exempt_from_basic_sales_tax)
  end
end
