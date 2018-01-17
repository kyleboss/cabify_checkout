class CreateScans < ActiveRecord::Migration[5.1]
  def change
    create_table :scans do |t|
      t.references :product, foreign_key: true
      t.references :checkout, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
