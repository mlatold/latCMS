class InsertWrapper < ActiveRecord::Migration
  def self.up
    Pages.create! route: "_"
  end

  def self.down
    Pages.delete_all :route => "_"
  end
end
