class CreateUserEmailAuthorisations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_email_authorisations do |t|
      t.string :email
      t.integer :role

      t.timestamps
    end
    add_index :user_email_authorisations, :email, unique: true
  end
end
