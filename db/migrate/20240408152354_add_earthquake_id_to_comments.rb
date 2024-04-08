class AddEarthquakeIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :earthquake, null: false, foreign_key: true
  end
end
