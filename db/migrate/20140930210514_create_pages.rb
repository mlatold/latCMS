class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :route
      t.text :content

      t.timestamps
    end

    add_index :pages, :route, unique: true
  end
end
