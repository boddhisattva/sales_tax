## About

Based on the [given problem statement](https://github.com/boddhisattva/sales_tax/blob/master/problem_statement.md) this is a program that calculates sales tax and prints out a receipt which has the pricing details(including tax) related to the purchase of each item. One can **read more about design decisions** based on which how this app is built from [this section](https://github.com/boddhisattva/sales_tax/blob/master/README.md#code-related-design-decisions). You can see how a *purchase receipt* looks like from [the sample program output section](https://github.com/boddhisattva/sales_tax/blob/master/README.md#program-output).

## Code related design decisions

* The entities related to the problem domain are - Line Item, Receipt, Shopping Cart and  Tax
* The different modules used with regard to the application are meant to serve a specific purpose or in other words have a single responsibility. A little more about the purpose of each module is given below:
  * `SalesTax` - This module is the entrypoint of the command line application. It's responsible to call other relevant modules in order to generate receipt details related to a purchase
  * `ReceiptCsvParser` - This module is a CSV parser for a file that contains information about the items to be purchased
  * `Item` - This module maintains information specific to each Item
  * `ShoppingCart` - This module is used to maintain shopping cart information
  * `Sales Tax Calculator` - This module is used to calculate sales tax for an item
  * `ReceiptGenerator` - This module is used to generate receipt details based on a purchase of items

## Other implementation details
* Have used typespecs and some of the module attributes like `moduledoc` and `doc` as a source of app related documentation
* For Code Style and formatting have used Elixir's built in formatter and [Credo](https://github.com/rrrene/credo)

### Assumptions
* The program accepts Comma Separated Values(CSV) as input. Hence I've made use of a `CsvParser` to read CSV data.
* The CSV files are to be placed in the `input` directory inorder to be read by the program
* Price is a positive number
* Product quantity is a positive integer.
* Products having the keyword "imported" are identified as imported items
* Products exempted from basic sales tax are based on pre defined keywords corresponding to the product name

## Usage

### Dependencies
* Elixir 1.7
* Please refer to `mix.exs` for the other dependencies

### Setup

* Run `mix deps.get` from a project's root directory to install the related dependencies.

### Running the program
From the projects root directory, please follow the below steps in order to run the program:


  * Build an escript(an executable that can be invoked from the command line.) for the project on any machine that has Erlang/OTP installed  with the command:
    `mix escript.build`

  * Running the executable - In order to run the executable we need to provide an input filename. Sample input files are already included under the `input` directory. The command for running the executable with a sample input file is:

    `./sales_tax --filename=input/shopping_basket1.csv`

### Running the tests
* One can run the tests from the project's root directory with the command `mix test`

### Program Output

* Below is a sample program output run against the command `./sales_tax --filename=input/shopping_basket3.csv`

```
1, imported bottle of perfume, 32.19
1, bottle of perfume, 20.89
1, packet of headache pills, 9.75
1, imported box of chocolates, 11.85

Sales Taxes: 6.7
Total: 74.68
```

### Scope for further improvements
* Replacing Float related usage with [Decimal](https://github.com/ericmj/decimal)
* Get a list of items exempt from basic sales tax based on user input
* Incorporate more taxes related to a product like GST etc.,

### Feedback
* Feel free to mail me your thoughts about the app on mail4mohnish@gmail.com
