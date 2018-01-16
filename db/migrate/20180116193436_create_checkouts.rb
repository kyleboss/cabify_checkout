class CreateCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :checkouts do |t|
      t.string :status
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
