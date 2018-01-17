describe Scan do
  describe '#total_cost' do
    let(:scan) { FactoryBot.build_stubbed(:scan, product: product, quantity: 5) }
    let(:product) { FactoryBot.build_stubbed(:product) }
    before(:each) { allow(product).to receive(:total_cost) { 19 } }
    subject { scan.total_cost }
    context 'no currency is given' do
      it 'defaults to euros & passes it as well as the quantity over to product#total_cost' do
        expect(product).to receive(:total_cost).with(5, :EUR)
        scan.total_cost
      end
    end

    context 'currency is given' do
      it 'passes the given currency as well as the quantity over to product#total_cost' do
        expect(product).to receive(:total_cost).with(5, :EUR)
        scan.total_cost(:EUR)
      end
    end

    it 'returns the value of product#total_cost' do
      expect(subject).to eq 19
    end
  end
end
