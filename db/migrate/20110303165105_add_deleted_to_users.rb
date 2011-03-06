class AddDeletedToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :deleted, :boolean, :default => false
  end

  def self.down
    drop_column :users, :deleted
  end
end
