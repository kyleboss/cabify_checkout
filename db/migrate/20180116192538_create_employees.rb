class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :privilege_rank
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
