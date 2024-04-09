class RemoveEarthquakesIdFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :earthquakes_id
  end
end
