# frozen_string_literal: true

class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.references :assessment, null: false, foreign_key: true
      t.references :service_provider, foreign_key: { to_table: 'users' }
      t.integer :status
      t.integer :price_cents
      t.timestamps
    end
  end
end
