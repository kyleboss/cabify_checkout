# frozen_string_literal: true
require 'money'
require 'money/bank/google_currency'
class ExchangeRateService
  def self.exchange_rate(base_currency, resulting_currency)
    base_currency == resulting_currency ? 1 : currency_bank.get_rate(base_currency, resulting_currency).to_f
  end

  def self.valid_currency?(currency)
    currency_symbol_mappings[currency.downcase.to_sym]
  end

  def self.currency_symbol_mappings
    @_currency_symbol_mappings = { eur: '€', usd: '$', gbp: '£' }
  end

  def self.valid_currencies
    @_valid_currencies ||= currency_symbol_mappings.map { |c, s| { code: c, symbol: s } }
  end

  private_class_method

  def self.currency_bank
    @_currency_bank ||= Money::Bank::GoogleCurrency.new
  end
end
