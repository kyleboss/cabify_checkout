describe Checkout do
  describe '#scan' do
    after(:each) { checkout.scan(product.id, 5) }
    let(:Checkout) { FactoryBot.build_stubbed(:Checkout) }
    let(:product) { FactoryBot.build_stubbed(:product) }
    let(:scan) { FactoryBot.build_stubbed(:scan, checkout_id: checkout&.id, product_id: product&.id, quantity: 1) }
    describe Product do
      subject { Product }
      before(:each) do
        allow(checkout).to receive(:scan_for).with(product) { scan }
        allow(checkout).to receive(:update_quantity_or_create_scan).with(product, 5, scan)
      end
      it { is_expected.to receive(:retrieve_product).with(product.id) { product } }
    end

    describe 'Checkout' do
      subject { checkout }
      before(:each) do
        allow(Product).to receive(:retrieve_product).with(product&.id) { product }
        allow(checkout).to receive(:scan_for).with(product) { scan }
        allow(checkout).to receive(:update_quantity_or_create_scan).with(product, 5, scan)
      end

      it { is_expected.to receive(:scan_for).with(product) { scan } }
      it { is_expected.to receive(:update_quantity_or_create_scan).with(product, 5, scan) }
    end
  end

  describe 'update_quantity_or_create_scan' do
    subject { checkout.send(:update_quantity_or_create_scan, product, quantity, scan) }
    let(:Checkout) { FactoryBot.create(:Checkout) }
    let(:product) { FactoryBot.create(:product) }
    let(:scan) { FactoryBot.create(:scan, checkout_id: checkout&.id, product_id: product&.id, quantity: 1) }
    let(:quantity) { 2 }

    context 'no products exist for the product identifier given' do
      let(:product) { nil }
      it 'throws an InvalidActiveRecord Exception' do
        expect { subject }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end

    context 'quantity makes the total quantity of scan negative' do
      let(:quantity) { -3 }
      it 'throws an InvalidActiveRecord Exception' do
        expect { subject }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end

    context 'within the current Checkout, this product has already been scanned' do
      it 'adds increases the quantity of the existing scan by quantity' do
        checkout.send(:update_quantity_or_create_scan, product, quantity, scan)
        expect(scan.quantity).to eq 3
      end

      describe 'Scans.count' do
        let!(:scan) { FactoryBot.create(:scan, checkout_id: checkout&.id, product_id: product&.id, quantity: 1) }
        subject { checkout.send(:update_quantity_or_create_scan, product, quantity, scan) }
        it 'increases by 0' do
          expect { subject }.to change { Scan.count }.by(0)
        end
      end
    end

    context 'within the current Checkout, this product has not already been scanned' do
      let(:scans) { nil }
      subject { checkout.send(:update_quantity_or_create_scan, product, quantity, scan) }
      describe 'Scans.count' do
        it 'increases by 1' do
          expect { subject }.to change { Scan.count }.by(1)
        end
      end
    end
  end

  describe '#scan_for' do
    before(:each) { allow(checkout).to receive(:scans) { [scan].compact } }
    let(:Checkout) { FactoryBot.build_stubbed(:Checkout) }
    let(:product) { FactoryBot.build_stubbed(:product) }
    let(:scan) { FactoryBot.build_stubbed(:scan, product_id: product&.id) }
    subject { checkout.send(:scan_for, product) }
    context 'scans is an empty array' do
      let(:scan) { nil }
      it { is_expected.to be_nil }
    end
    context 'product_obj is nil' do
      let(:product) { nil }
      let(:scan) { FactoryBot.build_stubbed(:scan, product_id: 5) }
      it { is_expected.to be_nil }
    end
    context 'none of the scans for this Checkout is for the given product' do
      let(:scan) { FactoryBot.build_stubbed(:scan, product_id: (product.id)+1) }
      it { is_expected.to be_nil }
    end
    context 'a single scan in this Checkout is for the given product' do
      let(:scan) { FactoryBot.build_stubbed(:scan, product_id: product.id) }
      it { is_expected.to eq scan }
    end
  end

  describe '#total' do
    let(:Checkout) { FactoryBot.build_stubbed(:Checkout) }
    let(:scans) { [scan1, scan2, scan3] }
    let(:scan1) { FactoryBot.build_stubbed(:scan, quantity: 1) }
    let(:scan2) { FactoryBot.build_stubbed(:scan, quantity: 4) }
    let(:scan3) { FactoryBot.build_stubbed(:scan, quantity: 9) }
    before(:each) { allow(checkout).to receive(:scans) { scans } }
    subject { checkout.total(:USD) }

    context 'scans are empty' do
      let(:scans) { [] }
      it { is_expected.to eq 0 }
    end

    context 'scans are not empty' do
      it "calls all of the scan's total_cost methods" do
        expect(scan1).to receive(:total_cost).with(:USD) { 12 }
        expect(scan2).to receive(:total_cost).with(:USD) { 2 }
        expect(scan3).to receive(:total_cost).with(:USD) { 0 }
        checkout.total(:USD)
      end
      it "sums up all of the scan's total_cost methods" do
        allow(scan1).to receive(:total_cost) { 12 }
        allow(scan2).to receive(:total_cost) { 2 }
        allow(scan3).to receive(:total_cost) { 0 }
        checkout.total
        expect(subject).to eq 14
      end
    end
  end
end
