class AddStoreIdToTours < ActiveRecord::Migration
  def change
    add_column 	:tours, :store_id, :integer, after: :end_date  	
    add_column 	:tours, :participant_num, :integer, after: :end_date
  end
end
