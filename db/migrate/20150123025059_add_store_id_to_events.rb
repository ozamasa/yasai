class AddStoreIdToEvents < ActiveRecord::Migration
  def change
    add_column 		:events, :store_id, :integer, after: :id  	
    add_column 		:events, :notes, :text, after: :end_at
    remove_column 	:events, :place
    remove_column 	:events, :contact
  end
end
