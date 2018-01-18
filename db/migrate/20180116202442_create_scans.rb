class CreateScans < ActiveRecord::Migration[5.1]
  def change
    create_table :scans do |t|
      t.references :product, foreign_key: true, null: false
      t.references :checkout, foreign_key: true, null: false
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
