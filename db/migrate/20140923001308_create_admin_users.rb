class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      t.string :email
      t.string :password_digest
      t.string :user_secret
      t.timestamp :last_login

      t.timestamps
    end
  end
end
