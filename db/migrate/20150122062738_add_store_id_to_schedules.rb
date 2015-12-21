class AddStoreIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :store_id, :integer, after: :date
  end
end
