defmodule ShoppingCart do
  defstruct total: 0, sales_tax: 0, items: []

  def new, do: %__MODULE__{}
end
