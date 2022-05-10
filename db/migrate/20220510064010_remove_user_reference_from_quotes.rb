# frozen_string_literal: true

class RemoveUserReferenceFromQuotes < ActiveRecord::Migration[7.0]
  def change
    remove_reference :quotes, :service_provider, index: true, foreign_key: { to_table: 'users' }
  end
end
