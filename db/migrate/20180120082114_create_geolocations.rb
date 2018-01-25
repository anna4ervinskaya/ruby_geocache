class CreateGeolocations < ActiveRecord::Migration[5.0]
  def change
    create_table :geolocations do |t|
      t.text :message
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
