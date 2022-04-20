# frozen_string_literal: true

class RemoveStatusFromQuotes < ActiveRecord::Migration[7.0]
  def change
    remove_column :quotes, :status, :integer
  end
end
