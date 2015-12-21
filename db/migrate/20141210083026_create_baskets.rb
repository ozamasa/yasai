class CreateBaskets < ActiveRecord::Migration
  def change
    create_table :baskets do |t|
      t.integer :user_id
      t.references :item
      t.integer	:number
      t.timestamps
    end
  end
end
