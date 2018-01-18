# frozen_string_literal: true

class CreateCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :checkouts, &:timestamps
  end
end
