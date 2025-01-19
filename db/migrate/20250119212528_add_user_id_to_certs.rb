class AddUserIdToCerts < ActiveRecord::Migration[8.0]
  def change
    add_reference :certs, :user, null: false, foreign_key: true
  end
end
