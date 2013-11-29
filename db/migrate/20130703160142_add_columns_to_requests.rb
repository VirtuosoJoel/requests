class AddColumnsToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :description, :string
    add_column :requests, :qty, :integer
    add_column :requests, :closed, :boolean
    rename_column :requests, :name, :part
  end
end
