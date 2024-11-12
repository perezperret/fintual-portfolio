# Fintual Portfolio

A simple ruby library that allows creating a portfolio and entering stock positions.
Relevant code is in `app/models/portfolio`.

## Set up environment
Must install bundler and the latest version of ruby. Run `bundle install` to set up dependencies.

## Demo
A price history is included for the past five years (up to Nov 8, 2024). A `demo` script is included, which will initialize a `SamplePortfolio` with some positions, and start an IRB console.

To use it, run `ruby ./demo.rb` from a shell.

Once in the console, you can do things like:
```ruby
SamplePortfolio.profit_between(Date.new(2022,5,11),Date.new(2024,7,22))
SamplePortfolio.total_value_on(Date.new(2024,11,8))
SamplePortfolio.annualized_return_between(Date.new(2020,11,3),Date.new(2024,11,8))
```

## Tests
As a sanity check, there are some simple tests in the `spec` directory. Tests can be run with `bundle exec rspec`

## Limitations
1. `ActiveSupport::CoreExt::Date` must be used for price lookup to work.
2. Valid open market dates must be used (eg. weekends will crash the program).

## Prompt
```text
Create a simple Portfolio class that contains a collection of Stock objects and includes a Profit method. This method should accept two dates and return the portfolio’s profit between those dates. Assume that each Stock has a Price method that takes a date as input and returns the stock’s price on that date. Bonus Track: Be able to get the annualized return of the portfolio between the given dates
```
