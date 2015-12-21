class Tour < ActiveRecord::Base

  belongs_to :store
  has_many :orders

end
