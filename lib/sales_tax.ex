defmodule SalesTax do
  @moduledoc """
  Documentation for SalesTax.
  """

  @doc """
  Compute Sales Tax.

  ## Examples

      iex> SalesTax.compute
      ["Quantity, Product, Price", "1, book, 12.49", "1, music cd, 14.99",
 "1, chocolate bar, 0.85"]

  """
  def compute do
    rows =
      File.stream!("input/shopping_basket1.csv")
      |> Enum.to_list

    [head | items] = rows

    products = Enum.map items, fn item ->
                  product = item |> String.split(",")
                  product = %Item{quantity: String.trim(Enum.at(product, 0)), name: String.trim(Enum.at(product, 1)), price: String.trim(Enum.at(product, 2))}
                  imported?(product)
                end


  end

  defp imported?(item) do
    %{ item | imported: String.contains?(item.name, "imported")}
  end

end
