class RenameBandsToRequests < ActiveRecord::Migration
  def change
    rename_table :bands, :requests
  end
end
