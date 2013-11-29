class AddDefaultValueToShowAttribute < ActiveRecord::Migration
  def change
    change_column :requests, :closed, :boolean, :default => false
  end
end
