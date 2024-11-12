require "active_support/core_ext/date"
require "./app/models/portfolio"
require "irb"

SamplePortfolio = Portfolio.new
SamplePortfolio.stocks = [
  ["AAPL", 10, Date.new(2020, 11, 3)],
  ["NFLX", 8, Date.new(2021, 3, 22)],
  ["MSFT", 15, Date.new(2022, 1, 18)],
  ["SBUX", 12, Date.new(2024, 4, 4)]
].map {
  {
    symbol: _1,
    quantity: _2,
    purchase_date: _3,
    purchase_price_cents: PriceHistory.price_cents_for(_1, _3)
  }
}

IRB.start
