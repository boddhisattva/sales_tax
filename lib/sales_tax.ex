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
      |> Stream.map(&String.trim/1)
      |> Enum.to_list

    [head | items] = rows

    products = Enum.map items, fn item ->
                  product = item |> String.split(",")
                  %Item{quantity: Enum.at(product, 0), name: Enum.at(product, 1), price: Enum.at(product, 2)}
                end
  end
end
