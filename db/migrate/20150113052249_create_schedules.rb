class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date	:date
      t.integer	:producer_id
      t.integer	:cultivar_id
      t.integer	:amount
      t.timestamps
    end
  end
end
