class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string		:name
      t.timestamps
    end

    Store.create(:id => 1, :name => 'JAあづみ')
    Store.create(:id => 2, :name => 'ほりがねの里')

  end
end
