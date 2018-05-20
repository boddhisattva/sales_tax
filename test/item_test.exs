defmodule ItemTest do
  use ExUnit.Case

  describe "imported?" do
    test "An item having imported in it's name should be treated as an imported item" do
      item = %Item{quantity: 1, name: "imported bottle of perfume", price: 47.5}

      assert Item.imported?(item) == true
    end

    test "An item not having imported in it's name is not an imported item" do
      item = %Item{quantity: 1, name: "bottle of perfume", price: 47.5}

      assert Item.imported?(item) == false
    end
  end


  describe "basic_sales_tax_applicable?" do
    test "An item that belongs to food, book or medical products related categories is treated exempt from basic sales tax" do
      item = %Item{quantity: 1, name: "The tale of two cities book", price: 47.5}

      assert Item.basic_sales_tax_applicable?(item) == false
    end

    test "An item that does not belong to food, book or medical products related categories is not exempt from basic sales tax" do
      item = %Item{quantity: 1, name: "bottle of perfume", price: 47.5}

      assert Item.basic_sales_tax_applicable?(item) == true
    end
  end
end
