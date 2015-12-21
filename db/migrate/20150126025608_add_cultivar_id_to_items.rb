class AddCultivarIdToItems < ActiveRecord::Migration
  def change
    add_column 		:items, :cultivar_id, :integer, after: :code  	
  	add_column		:items, :unit, :string
	remove_column	:items, :size
  end
end
