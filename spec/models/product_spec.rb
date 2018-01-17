describe Product do
  let(:product) { FactoryBot.build_stubbed(:product, base_currency: base_currency, base_price: 0.75) }
  let(:currency) { :EUR }
  let(:base_currency) { :GBP }
  let(:quantity) { 2 }
  describe '#total_cost' do
    subject { product.total_cost(quantity, currency) }

    context 'quantity is negative' do
      let(:quantity) { -1 }
      it 'throws a negative currency exception' do
        expect { product.total_cost(quantity, currency) }.to raise_exception(Exceptions::NegativeQuantity)
      end
    end

    context 'currency is invalid' do
      let(:currency) { :zzz }
      before(:each) { expect(ExchangeRateService).to receive(:valid_currency?).with(currency) { false } }
      it 'throws an invalid currency exception' do
        expect { product.total_cost(quantity, currency) }.to raise_exception(Exceptions::InvalidCurrency)
      end
    end

    context 'quantity is positive & currency is valid' do
      let(:currency) { :USD }
      before(:each) { expect(ExchangeRateService).to receive(:exchange_rate).with(:GBP, :USD) { 0.5 } }
      it { is_expected.to eq 0.75 }
    end
  end

  describe '#retrieve_product' do
    let!(:product1) { FactoryBot.create(:product, barcode_number: '123', title: 'Tshirt') }
    let!(:product2) { FactoryBot.create(:product, barcode_number: '3879345789534', title: 'abc') }
    let!(:product3) { FactoryBot.create(:product, barcode_number: '3879345789534', title: 'Tshirt') }
    let(:identifier) { nil }
    subject { Product.retrieve_product(identifier) }
    context 'identifier matches barcode number' do
      let(:identifier) { '123' }
      it { is_expected.to eq product1 }
    end
    context 'identifier matches title' do
      let(:identifier) { 'abc' }
      it { is_expected.to eq product2 }
    end
    context 'identifier does not match any products' do
      let(:identifier) { 'abc123' }
      it { is_expected.to be_nil }
    end
    context 'identifier matches multiple products' do
      let(:identifier) { 'Tshirt' }
      it { is_expected.to eq product1 }
    end
  end
end
