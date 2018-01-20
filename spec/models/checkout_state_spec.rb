# frozen_string_literal: true

describe CheckoutState do
  let(:checkout) { FactoryBot.build_stubbed(:checkout, currency: :USD) }
  let(:update_obj) { checkout }
  let(:scan) { FactoryBot.build_stubbed(:scan, checkout: checkout) }
  let(:checkout_state) { FactoryBot.build(:checkout_state, update_obj: update_obj) }
  let(:expected_currency) { { code: 'USD', symbol: '$' } }
  let(:expected_all_scanned_products) do
    { quantity: 5, title: 'Cabify T-Shirt', image_url: 'wwww.image.com', scan_id: scan.id }
  end
  let(:expected_all_charges) { { title: 'Cabify T-Shirt', quantity: 5, amount: 20.00 } }
  let(:expected_all_discounts) { [{ title: 'Buy 1 Get 1 T-shirt free', amount: 5.00 }] }
  describe '#initialize' do
    let(:update_obj) { checkout }
    before(:each) do
      expect(checkout).to receive(:scans) { [scan] }
      expect_any_instance_of(CheckoutState).to receive(:checkout).with(update_obj) { checkout }
      expect_any_instance_of(CheckoutState).to receive(:current_currency).with(checkout) { expected_currency }
      expect_any_instance_of(CheckoutState).to receive(:all_scanned_products).with([scan]) do
        expected_all_scanned_products
      end
      expect_any_instance_of(CheckoutState).to receive(:all_charges).with([scan]) { expected_all_charges }
      expect_any_instance_of(CheckoutState).to receive(:all_discounts).with([scan]) { expected_all_discounts }
      expect(checkout).to receive(:total) { 15 }
      expect_any_instance_of(CheckoutState).to receive(:priceify_number).with(15) { 15.00 }
    end

    describe '@checkout_id' do
      subject { checkout_state.instance_variable_get(:@checkout_id) }
      it { is_expected.to eq checkout.id }
    end

    describe '@currency' do
      subject { checkout_state.instance_variable_get(:@currency) }
      it { is_expected.to eq expected_currency }
    end

    describe '@scanned_products' do
      subject { checkout_state.instance_variable_get(:@scanned_products) }
      it { is_expected.to eq expected_all_scanned_products }
    end

    describe '@cart_summary' do
      subject { checkout_state.instance_variable_get(:@cart_summary) }
      it { is_expected.to eq(charges: expected_all_charges, discounts: expected_all_discounts, total: 15.00) }
    end
  end

  describe '#checkout' do
    subject { checkout_state.send(:checkout, update_obj) }
    context 'object passed into Checkout State is a scan' do
      let(:update_obj) { scan }
      it { is_expected.to eq scan.checkout }
    end
    context 'object passed into Checkout State is a checkout' do
      let(:update_obj) { checkout }
      it { is_expected.to eq checkout }
    end
  end

  describe '#current_currency' do
    before(:each) { allow(ExchangeRateService).to receive(:currency_symbol_mappings) { { eur: '€', usd: '$' } } }
    subject { checkout_state.send(:current_currency, checkout) }
    it { is_expected.to eq expected_currency }
  end

  describe '#all_scanned_products' do
    let(:product) { FactoryBot.build_stubbed(:product, title: 'Cabify Mug', image_url: 'www.google.com') }
    let(:scan) { FactoryBot.build_stubbed(:scan, quantity: 2, product: product) }
    subject { checkout_state.send(:all_scanned_products, [scan]) }
    it { is_expected.to eq [{ quantity: 2, title: 'Cabify Mug', image_url: 'www.google.com', scan_id: scan.id }] }
  end

  describe '#all_charges' do
    let(:product) { FactoryBot.build_stubbed(:product, title: 'Cabify Mug') }
    let(:scan) { FactoryBot.build_stubbed(:scan, quantity: 2, product: product) }
    subject { checkout_state.send(:all_charges, [scan]) }

    before(:each) do
      expect(scan).to receive(:total_cost).with(apply_discount: false) { 5.0 }
      expect(checkout_state).to receive(:priceify_number).with(5.0) { 5.00 }
    end

    it { is_expected.to eq [{ title: 'Cabify Mug', quantity: 2, amount: 5.00 }] }
  end

  describe '#all_discounts' do
    let(:scan) { FactoryBot.build_stubbed(:scan) }
    subject { checkout_state.send(:all_discounts, [scan]) }

    context 'Product is not a discounted product type' do
      it { is_expected.to eq [] }
    end

    context 'Product is a discount product type' do
      let(:scan) { FactoryBot.build_stubbed(:scan_bulk_product) }
      before(:each) { expect(scan).to receive(:discount_total) { discount_total } }

      context 'The total discount is less than or equal to zero' do
        let(:discount_total) { 0 }
        it { is_expected.to eq [] }
      end

      context 'The total discount is greater than zero' do
        let(:discount_total) { 9 }
        before(:each) do
          expect(checkout_state).to receive(:priceify_number).with(discount_total) { 9.00 }
          expect(checkout_state).to receive(:discount_title).with(scan) { 'Discount Title' }
        end

        it { is_expected.to eq [{ title: 'Discount Title', amount: 9.00 }] }
      end
    end
  end

  describe '#discount_title' do
    subject { checkout_state.send(:discount_title, scan) }
    let(:scan) { FactoryBot.build_stubbed(:scan, product: product) }

    context 'Product type is a Buy X Get X item' do
      let(:product) { FactoryBot.build_stubbed(:buy_x_get_x_product, title: 'Product', num_to_buy: 2, num_will_get: 1) }
      it { is_expected.to eq 'Buy 2 Products Get 1' }
    end

    context 'Product type is a Bulk item' do
      let(:product) { FactoryBot.build_stubbed(:bulk_product, title: 'Product') }
      it { is_expected.to eq 'Product Bulk Purchase' }
    end
  end

  describe '#priceify_number' do
    subject { checkout_state.send(:priceify_number, 9) }
    it { is_expected.to eq '9.00' }
  end
end
