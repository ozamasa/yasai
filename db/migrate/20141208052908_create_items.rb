class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string    :code
      t.string    :name
      t.integer   :size
      t.integer   :price
      t.text      :description
      t.string    :image_path
      t.integer   :producer_id
      t.datetime  :harvested_at
      
      t.timestamps
    end
  end
end
