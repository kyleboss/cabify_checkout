class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.string :type, null: false, default: :Product
      t.decimal :base_price, precision: 8, scale: 2, null: false
      t.string :base_currency, null: false, default: :EUR
      t.string :barcode_number, null: false
      t.integer :num_to_buy
      t.integer :num_will_get
      t.integer :bulk_threshold
      t.decimal :bulk_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
