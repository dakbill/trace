class AddUuidToDataSet < ActiveRecord::Migration
  def change
    add_column :data_sets, :uuid, :string
  end
end
