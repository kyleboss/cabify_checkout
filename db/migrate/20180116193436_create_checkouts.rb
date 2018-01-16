class CreateCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :checkouts do |t|
      t.string :status

      t.timestamps
    end
  end
end
