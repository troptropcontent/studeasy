# frozen_string_literal: true

class CreateSolutions < ActiveRecord::Migration[7.0]
  def change
    create_table :solutions do |t|
      t.references :quote, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
