class User < ActiveRecord::Base

  def display_auth
  	return unless self.auth
  	%w(システム管理者 職員 職員+生産者 生産者)[self.auth-1]
  end

  def self.auth_seloptions
  	[['システム管理者', 1], ['職員', 2], ['職員+生産者', 3], ['生産者', 4]]
  end

  def self.seloptions
  	User.all.map{|t| [t.name, t.id]}.to_h
  end

end
