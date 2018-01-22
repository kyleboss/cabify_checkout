# frozen_string_literal: true
describe Checkout do
  before(:each) do
    BuyXGetXProduct.create!(title: 'Cabify Voucher', barcode_number: 'VOUCHER', base_price: 5.00, base_currency: :EUR,
                           num_to_buy: 2, num_will_get: 1,
                           image_url: 'https://s3-us-west-2.amazonaws.com/kyleboss.com/cabify/voucher.jpg')
    BulkProduct.create!(title: 'Cabify T-Shirt', barcode_number: 'TSHIRT', base_price: 20.00, base_currency: :EUR,
                       bulk_threshold: 3, bulk_price: 19.00,
                       image_url: 'https://s3-us-west-2.amazonaws.com/kyleboss.com/cabify/tshirt.jpg')
    Product.create!(title: 'Cabify Coffee Mug', barcode_number: 'MUG', base_price: 7.50, base_currency: :EUR,
                   image_url: 'https://s3-us-west-2.amazonaws.com/kyleboss.com/cabify/mug.jpg')
  end

  context '' do
    it 'is expected to equal 25.00' do
      co = Checkout.new
      co.scan('VOUCHER')
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      price = co.total
      expect(price).to eq '25.00'
    end
  end

  context do
    it 'is expected to equal 32.50' do
      co = Checkout.new
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('MUG')
      price = co.total
      expect(price).to eq '32.50'
    end
  end

  context do
    it 'is expected to equal 25.00' do
      co = Checkout.new
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      price = co.total
      expect(price).to eq '25.00'
    end
  end

  context do
    it 'is expected to equal 81.00' do
      co = Checkout.new
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      price = co.total
      expect(price).to eq '81.00'
    end
  end

  context do
    it 'is expected to equal 74.50' do
      co = Checkout.new
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      co.scan('VOUCHER')
      co.scan('MUG')
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      price = co.total
      expect(price).to eq '74.50'
    end
  end
end
