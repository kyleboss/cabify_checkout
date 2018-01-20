describe Scan do
  let(:scan) { FactoryBot.build_stubbed(:scan, product: product, quantity: 5, checkout: checkout) }
  let(:checkout) { FactoryBot.build_stubbed(:checkout, currency: currency) }
  let(:product) { FactoryBot.build_stubbed(:product) }
  let(:currency) { "USD" }
  describe '#total_cost' do
    let(:apply_discount) { false }
    before(:each) { allow(product).to receive(:total_cost) { 19 } }
    subject { scan.total_cost(apply_discount: apply_discount) }
    context 'the discounts should not be applied' do
      let(:apply_discount) { false }
      let(:currency) { "USD" }
      it 'passes apply_discounts as well as the quantity, the currency, & apply_discount over to product#total_cost' do
        expect(product).to receive(:total_cost).with(5, "USD", false)
        scan.total_cost(apply_discount: false)
      end
    end

    context 'currency is not provided' do
      it 'assumes to apply discounts & passes it as well as thecurreny & quantity over to product#total_cost' do
        expect(product).to receive(:total_cost).with(5, "USD", true)
        scan.total_cost
      end
    end

    it 'returns the value of product#total_cost' do
      expect(subject).to eq 19
    end
  end

  describe '#discount_total' do
    subject { scan.discount_total }
    before(:each) do
      expect(scan).to receive(:total_cost).with(apply_discount: false) { 20 }
      expect(scan).to receive(:total_cost).with(apply_discount: true) { 5 }
    end
    it { is_expected.to eq 15 }
  end
end
