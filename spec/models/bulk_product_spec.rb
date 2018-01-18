describe BulkProduct do
  let(:bulk_product) do
    FactoryBot.build_stubbed(:bulk_product,
                             bulk_threshold: bulk_threshold,
                             base_price: base_price,
                             bulk_price: bulk_price)
  end

  let(:quantity) { 3 }
  let(:bulk_threshold) { 2 }
  let(:base_price) { 5 }
  let(:bulk_price) { 4 }
  describe '#price_per_unit' do
    subject { bulk_product.send(:price_per_unit, quantity) }
    context 'the number of units about to be purchased is less than the threshold' do
      let(:quantity) { 1 }
      it 'returns base_price' do
        expect(subject).to eq 5
      end
    end
    context 'the number of units about to be purchased is greater than or equal to the threshold' do
      it 'returns bulk_price' do
        expect(subject).to eq 4
      end
    end
  end
end