class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string	:name
      t.string	:name_kana
      t.string	:address
      t.string	:tel
      t.timestamps
    end
  end
end
