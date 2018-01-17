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
    @_valid_currencies ||= %i[eur usd jpy gbp cyp czk dkk eek huf ltl mtl pln sek sit skk chf isk nok bgn hrk rol ron
                              rub trl aud cad cny hkd idr krw myr nzd php sgd thb zar].freeze
  end
end