class CreateBruteForces < ActiveRecord::Migration
  def change
    create_table :brute_forces do |t|
      t.string :remote_ip
      t.integer :counter

      t.timestamps
    end
  end
end
