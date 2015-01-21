class User < ActiveRecord::Base

  def display_auth
  	return unless self.auth
  	%w(システム管理者 職員 会員)[self.auth　-　1]
  end

  def self.seloptions
  	[{'1' => 'システム管理者'}, {'2' => '職員'}, {'3' => '会員'}]
  end

end
