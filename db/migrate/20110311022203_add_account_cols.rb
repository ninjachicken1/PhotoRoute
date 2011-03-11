class AddAccountCols < ActiveRecord::Migration
  def self.up
    add_column :services, :service_user, :string
    add_column :services, :service_user_id, :string
    add_column :services, :service_token, :string
  end

  def self.down
    drop_column :services, :sercice_user
    drop_column :services, :sercice_user_id
    drop_column :services, :sercice_token
  end
end
