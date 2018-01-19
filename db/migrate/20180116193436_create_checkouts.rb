# frozen_string_literal: true

class CreateCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :checkouts do |t|
      t.string :currency, null: false, default: :EUR
      t.timestamps
    end
  end
end
