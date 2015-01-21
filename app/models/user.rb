class User < ActiveRecord::Base

  def display_auth
  	return unless self.auth
  	%w(システム管理者 職員 会員)[self.auth-1]
  end

  def self.auth_seloptions
  	[['システム管理者', 1], ['職員', 2], ['会員', 3]]
  end

end
