require "csv"

module PriceHistory
  extend self

  def price_cents_for(symbol, date)
    price_table.fetch(symbol).fetch(date)
  end

  private

  def price_table
    @price_table ||=
      CSV.read('./lib/price_history.csv', headers: true)
      .group_by { _1["symbol"] }
      .transform_values do |rows|
        rows.map { [Date.parse(_1["date"]), _1["price_cents"].to_i] }.to_h
      end
  end
end
