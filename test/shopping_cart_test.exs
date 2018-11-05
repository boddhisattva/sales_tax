defmodule ShoppingCartTest do
  use ExUnit.Case

  describe "initialize_cart_product" do
    test "It initializes a product with related price based on the sales tax wrt one item and the total quantity along with other product details" do
      total_sales_tax_from_one_item = 1.5

      product = %Item{
        basic_sales_tax_applicable: true,
        imported: false,
        name: "music cd",
        price: 14.99,
        quantity: 2
      }

      assert ShoppingCart.initialize_cart_product(total_sales_tax_from_one_item, product) ==
               %Item{
                 basic_sales_tax_applicable: true,
                 imported: false,
                 name: "music cd",
                 price: 32.98,
                 quantity: 2
               }
    end
  end

  describe "update" do
    test "updates shopping cart details based on a cart product's details" do
      shopping_cart = %ShoppingCart{items: [], sales_tax: 0, total: 0}

      cart_product = %Item{
        basic_sales_tax_applicable: true,
        imported: false,
        name: "music cd",
        price: 32.98,
        quantity: 2
      }
      total_sales_tax_from_one_item = 1.5

      assert ShoppingCart.update(shopping_cart, cart_product, total_sales_tax_from_one_item) ==
        %ShoppingCart{
          items: [
            %Item{
              basic_sales_tax_applicable: true,
              imported: false,
              name: "music cd",
              price: 32.98,
              quantity: 2
            }
          ],
          sales_tax: 3.0,
          total: 32.98
        }
    end
  end
end
