class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string		:title
      t.datetime	:start_at
      t.datetime	:end_at
      t.string		:place
      t.string		:contact
      t.timestamps
    end
  end
end
