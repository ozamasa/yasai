class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references 	:tour
      t.integer		:user_id
      t.integer 	:amount
      t.timestamps
    end
  end
end
