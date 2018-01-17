# frozen_string_literal: true

class ExchangeRateService
  def self.exchange_rate(base_currency, resulting_currency)
    base_currency == resulting_currency ? 1 : currency_bank.get_rate(base_currency, resulting_currency).to_f
  end

  def self.valid_currency?(currency)
    currency.downcase.in? valid_currencies
  end

  private_class_method

  def self.currency_bank
    @_currency_bank ||= Money::Bank::GoogleCurrency.new
  end

  def self.valid_currencies
    @_valid_currencies ||= %i[eur usd gbp].freeze
  end
end
