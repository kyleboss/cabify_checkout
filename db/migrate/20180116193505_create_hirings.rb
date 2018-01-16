class CreateHirings < ActiveRecord::Migration[5.1]
  def change
    create_table :hirings do |t|
      t.references :employee, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
