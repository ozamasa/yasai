class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
	  t.integer		:group_id
	  t.string		:name
      t.timestamps
    end
  end
end
