# frozen_string_literal: true
require 'money'
require 'money/bank/google_currency'
class ExchangeRateService
  def self.exchange_rate(base_currency, resulting_currency)
    base_currency == resulting_currency ? 1 : currency_bank.get_rate(base_currency, resulting_currency).to_f
  end

  def self.valid_currency?(currency)
    currency.downcase.to_sym.in?(valid_currencies.map do |currency|
      currency[:code]
    end)
  end

  def self.valid_currencies
    @_valid_currencies ||= [{ code: :eur, symbol: '€' }, { code: :usd, symbol: '$' }, { code: :gbp, symbol: '£' }]
  end

  private_class_method

  def self.currency_bank
    @_currency_bank ||= Money::Bank::GoogleCurrency.new
  end
end
