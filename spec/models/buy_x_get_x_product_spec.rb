describe BuyXGetXProduct do
  let(:buy_x_get_x_product) do
    FactoryBot.build_stubbed(:buy_x_get_x_product,
                             num_to_buy: num_to_buy,
                             num_will_get: num_will_get,
                             base_price: base_price)
  end

  let(:quantity) { 5 }
  let(:num_to_buy) { 2 }
  let(:num_will_get) { 1 }
  let(:base_price) { 10 }
  describe '#price_per_unit' do
    subject { buy_x_get_x_product.send(:price_per_unit, quantity) }
    context 'Eh...a normal situation' do
      it { is_expected.to eq 6 }
    end

    context 'The amount that the shopper gets for free is zero' do
      let(:num_will_get) { 0 }
      it { is_expected.to eq 10 }
    end

    context 'the number of products the shopper has to buy is the same as the number of products they get for free' do
      let(:num_to_buy) { 1 }
      it { is_expected.to eq 0 }
    end

    context 'the number of products purchased is 0' do
      let(:quantity) { 0 }
      it { is_expected.to eq base_price }
    end
  end

  describe '#num_units_received_free' do
    subject { buy_x_get_x_product.send(:num_units_received_free, quantity) }
    context 'Eh...a normal situation' do
      it { is_expected.to eq 2 }
    end

    context 'The amount that the shopper gets for free is zero' do
      let(:num_will_get) { 0 }
      it { is_expected.to eq 0 }
    end

    context 'the number of products the shopper has to buy is the same as the number of products they get for free' do
      let(:num_to_buy) { 1 }
      it { is_expected.to eq 5 }
    end

    context 'the number of products purchased is 0' do
      let(:quantity) { 0 }
      it { is_expected.to eq 0 }
    end
  end
end