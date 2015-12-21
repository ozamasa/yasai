class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string 	:code
      t.string 	:name
      t.date 	:start_date
      t.date 	:end_date
      t.string 	:conductor_id
      t.string 	:conductor_name
      t.timestamps
    end
  end
end
