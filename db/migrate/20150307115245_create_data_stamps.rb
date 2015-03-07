class CreateDataStamps < ActiveRecord::Migration
  def change
    create_table :data_stamps do |t|
      t.belongs_to :data_set, index: true
      t.string :parameter
      t.timestamp :record_time
      t.integer :channel
      t.float :sensor_value
      t.string :unit

      t.timestamps
    end
  end
end
