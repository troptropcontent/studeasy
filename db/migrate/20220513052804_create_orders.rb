class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :status
      t.integer :amount_cents
      t.string :checkout_session_id
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
