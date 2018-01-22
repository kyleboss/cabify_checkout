# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
BuyXGetXProduct.create(title: 'Cabify Voucher', barcode_number: 'VOUCHER', base_price: 5.00, base_currency: :EUR,
                        num_to_buy: 2, num_will_get: 1,
                        image_url: 'https://s3-us-west-2.amazonaws.com/kyleboss.com/cabify/voucher.jpg')
BulkProduct.create(title: 'Cabify T-Shirt', barcode_number: 'TSHIRT', base_price: 20.00, base_currency: :EUR,
                    bulk_threshold: 3, bulk_price: 19.00,
                    image_url: 'https://s3-us-west-2.amazonaws.com/kyleboss.com/cabify/tshirt.jpg')
Product.create(title: 'Cabify Coffee Mug', barcode_number: 'MUG', base_price: 7.50, base_currency: :EUR,
                image_url: 'https://s3-us-west-2.amazonaws.com/kyleboss.com/cabify/mug.jpg')