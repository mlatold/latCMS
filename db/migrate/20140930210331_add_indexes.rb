class AddIndexes < ActiveRecord::Migration
  def change
    add_index :admin_users, :email, unique: true
    add_index :admin_users, :user_secret

    add_index :brute_forces, :remote_ip
  end
end
