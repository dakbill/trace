class DataSetsHasManyAndBelongsToUsers < ActiveRecord::Migration
  def change
  	create_table :data_sets_users, id: false do |t|
      t.belongs_to :data_set, index: true
      t.belongs_to :user, index: true
    end
  end
end
