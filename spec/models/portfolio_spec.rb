require "active_support/core_ext/date"
require "./app/models/portfolio"

RSpec.describe Portfolio do
  let(:portfolio) do
    Portfolio.new.tap do |portfolio|
      portfolio.stocks = [
        {
          symbol: "AAPL",
          quantity: 10,
          purchase_date: Date.new(2020, 1, 1),
          purchase_price_cents: 250_00
        }
      ]
    end
  end

  subject { portfolio.profit_between(Date.new(2023, 1, 1), Date.new(2024, 1, 1)) }

  before do
    allow(PriceHistory).to(
      receive(:price_cents_for)
      .with("AAPL", Date.new(2023, 1, 1))
      .and_return(200_00)
    )

    allow(PriceHistory).to(
      receive(:price_cents_for)
      .with("AAPL", Date.new(2024, 1, 1))
      .and_return(300_00)
    )
  end

  it "calculates profit between two dates" do
    expect(subject).to eq(1000.0)
  end

  context "when the end date is before the purchase date" do
    subject { portfolio.profit_between(Date.new(2019, 1, 1), Date.new(2019, 12, 31)) }

    it "calculates the profit ignoring the stock" do
      expect(subject).to eq(0)
    end
  end

  context "when the start date is before the purchase date" do
    subject { portfolio.profit_between(Date.new(2019, 1, 1), Date.new(2024, 1, 1)) }

    it "calculates the profit using the purchase price" do
      expect(subject).to eq(500.0)
    end
  end
end
