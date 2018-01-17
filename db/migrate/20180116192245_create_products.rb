class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.string :image_url
      t.string :type
      t.decimal :base_price, precision: 8, scale: 2
      t.string :base_currency
      t.string :barcode_number
      t.integer :num_to_buy
      t.integer :num_will_get
      t.integer :bulk_threshold
      t.integer :bulk_price

      t.timestamps
    end
  end
end
