describe Checkout do
  let(:checkout) { FactoryBot.create(:checkout) }
  let(:product) { FactoryBot.create(:product) }
  let(:scan) { FactoryBot.create(:scan, checkout_id: checkout.id, product_id: product.id, quantity: 1) }
  let(:quantity) { 2 }

  before(:each) { allow(Product).to receive(:retrieve_product).with(product&.id) { product } }

  describe '#scan' do
    subject { checkout.scan(product.id, quantity) }

    context 'no products exist for the product identifier given' do
      let(:product) { nil }
      it 'throws an InvalidActiveRecord Exception' do
        expect { checkout.scan(nil, quantity) }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end

    context 'quantity makes the total quantity of scan negative' do
      let(:quantity) { -3 }
      it 'throws an InvalidActiveRecord Exception' do
        expect { checkout.scan(product.id, quantity) }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end

    context 'within the current checkout, this product has already been scanned' do
      let!(:scan) { FactoryBot.create(:scan, checkout_id: checkout.id, product_id: product.id, quantity: 5) }
      before(:each) { allow(checkout).to receive(:scans) { [scan] } }
      it 'adds increases the quantity of the existing scan by quantity' do
        checkout.scan(product.id, quantity)
        expect(scan.quantity).to eq 7
      end

      describe 'Scans.count' do
        it 'increases by 0' do
          expect { checkout.scan(product.id, quantity) }.to change { Scan.count }.by(0)
        end
      end
    end

    context 'within the current checkout, this product has not already been scanned' do
      let(:scans) { nil }
      describe 'Scans.count' do
        it 'increases by 1' do
          expect { checkout.scan(product.id, quantity) }.to change { Scan.count }.by(1)
        end
      end
    end
  end

  describe '#total'
end
