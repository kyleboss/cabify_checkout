# frozen_string_literal: true

describe Checkout do
  describe '#scan' do
    after(:each) { checkout.scan(product.id, 5) }
    let(:checkout) { FactoryBot.build_stubbed(:checkout) }
    let(:product) { FactoryBot.build_stubbed(:product) }
    let(:scan) { FactoryBot.build_stubbed(:scan, checkout_id: checkout&.id, product_id: product&.id, quantity: 1) }
    describe Product do
      subject { Product }
      before(:each) do
        allow(checkout).to receive(:scan_for).with(product) { scan }
        allow(checkout).to receive(:update_quantity_or_create_scan).with(product, 5, scan, true)
      end
      it { is_expected.to receive(:retrieve_product).with(product.id) { product } }
    end

    describe 'checkout' do
      subject { checkout }
      before(:each) do
        allow(Product).to receive(:retrieve_product).with(product&.id) { product }
        allow(checkout).to receive(:scan_for).with(product) { scan }
        allow(checkout).to receive(:update_quantity_or_create_scan).with(product, 5, scan, true)
      end

      it { is_expected.to receive(:scan_for).with(product) { scan } }
      it { is_expected.to receive(:update_quantity_or_create_scan).with(product, 5, scan, true) }
    end
  end

  describe 'update_quantity_or_create_scan' do
    subject { checkout.send(:update_quantity_or_create_scan, product, quantity, scan) }
    let(:checkout) { FactoryBot.create(:checkout) }
    let(:product) { FactoryBot.create(:product) }
    let(:scan) { FactoryBot.create(:scan, checkout_id: checkout&.id, product_id: product&.id, quantity: 1) }
    let(:quantity) { 2 }

    context 'no products exist for the product identifier given' do
      let(:product) { nil }
      it 'throws an InvalidActiveRecord Exception' do
        expect { subject }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end

    context 'within the current checkout, this product has already been scanned' do
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

    context 'within the current checkout, this product has not already been scanned' do
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
    let(:checkout) { FactoryBot.build_stubbed(:checkout) }
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
    context 'none of the scans for this checkout is for the given product' do
      let(:scan) { FactoryBot.build_stubbed(:scan, product_id: product.id + 1) }
      it { is_expected.to be_nil }
    end
    context 'a single scan in this checkout is for the given product' do
      let(:scan) { FactoryBot.build_stubbed(:scan, product_id: product.id) }
      it { is_expected.to eq scan }
    end
  end

  describe '#total' do
    let(:checkout) { FactoryBot.build_stubbed(:checkout) }
    let(:scans) { [scan1, scan2, scan3] }
    let(:scan1) { FactoryBot.build_stubbed(:scan, quantity: 1) }
    let(:scan2) { FactoryBot.build_stubbed(:scan, quantity: 4) }
    let(:scan3) { FactoryBot.build_stubbed(:scan, quantity: 9) }
    before(:each) { allow(checkout).to receive(:scans) { scans } }
    subject { checkout.total }

    context 'scans are empty' do
      let(:scans) { [] }
      it { is_expected.to eq '0.00' }
    end

    context 'scans are not empty' do
      it "calls all of the scan's total_cost methods" do
        expect(scan1).to receive(:total_cost) { 12 }
        expect(scan2).to receive(:total_cost) { 2 }
        expect(scan3).to receive(:total_cost) { 0 }
        checkout.total
      end
      it "sums up all of the scan's total_cost methods" do
        allow(scan1).to receive(:total_cost) { 12 }
        allow(scan2).to receive(:total_cost) { 2 }
        allow(scan3).to receive(:total_cost) { 0 }
        checkout.total
        expect(subject).to eq '14.00'
      end
    end
  end

  describe '#scans' do
    let(:checkout) { FactoryBot.create(:checkout) }
    let(:scan) { FactoryBot.create(:scan, checkout_id: checkout&.id, quantity: 1) }
    it 'returns all of the scans that belong to the checkout' do
      expect(checkout.scans).to eq [scan]
    end
  end
end
