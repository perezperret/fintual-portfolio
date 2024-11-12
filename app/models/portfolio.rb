require "./lib/price_history"

class Portfolio
  attr_reader :stocks

  def initialize
    @stocks = []
  end

  def stocks=(stocks_params)
    stocks_params.each { add_stock(_1) }
  end

  def add_stock(stock_params)
    @stocks << Stock.new(
      stock_params[:symbol],
      stock_params[:quantity],
      stock_params[:purchase_date],
      stock_params[:purchase_price_cents]
    )
  end

  def profit_between(start_date, end_date)
    @stocks.inject(0) do |sum, stock|
      if end_date < stock.purchase_date
        sum
      elsif start_date < stock.purchase_date
        sum + stock.quantity * (stock.price_cents_on(end_date) - stock.purchase_price_cents)
      else
        sum + stock.quantity * (stock.price_cents_on(end_date) - stock.price_cents_on(start_date))
      end
    end.to_f / 100
  end

  def annualized_return_between(start_date, end_date)
    days = (end_date - start_date).to_i

    initial_value = total_value_on(start_date)
    profit = profit_between(start_date, end_date)

    return_rate = profit / initial_value

    (1 + return_rate) ** (365.0 / days) - 1
  end

  def total_value_on(date)
    @stocks.sum { _1.quantity * _1.price_cents_on(date) }.to_f / 100
  end

  class Stock
    attr_reader :symbol, :quantity, :purchase_date, :purchase_price_cents

    def initialize(symbol, quantity, purchase_date, purchase_price_cents)
      @symbol = symbol
      @quantity = quantity
      @purchase_date = purchase_date
      @purchase_price_cents = purchase_price_cents
    end

    def price_cents_on(date)
      PriceHistory.price_cents_for(symbol, date)
    end
  end
end
