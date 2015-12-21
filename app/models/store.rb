class Store < ActiveRecord::Base

  has_many :schedules
  has_many :events
  has_many :tours

  def self.seloptions
  	Store.all.map{|t| [t.name, t.id]}.to_h		
  end
end
