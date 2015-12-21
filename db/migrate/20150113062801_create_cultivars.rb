class CreateCultivars < ActiveRecord::Migration
  def change
    create_table :cultivars do |t|
      t.references	:category
      t.string		:name
      t.integer		:unit
      t.timestamps
    end
  end
end
