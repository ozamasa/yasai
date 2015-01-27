class Cultivar < ActiveRecord::Base

  belongs_to :category
  has_many :schedules
  has_many :items

  def self.seloptions(category_id = nil)
  	tbl = Cultivar.arel_table
  	conditions = tbl[:category_id].eq(category_id) if category_id
  	cultivars = Cultivar.where(conditions)
  	cultivars.map{|t| [t.name, t.id]}.to_h
  end
  
end
